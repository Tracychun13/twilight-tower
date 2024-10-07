extends CharacterBody2D;

const SPEED = 80.0
const ZERO_VEC = Vector2(0.0, 0.0)
var ghost_drag_vector = Vector2(0.0, 0.0)
var is_attacking = false
var can_attack = false
var is_detained = false
var is_captured_by_ghost = false
var health = 100;
var shieldHealth = 100;
var is_shielding = false
@onready var sprite2d = $AnimatedSprite2D
@onready var bat = $"../Bat"
@onready var collision = $CollisionPolygon2D

func die():
	sprite2d.play("die")
	set_physics_process(false)
	set_process_input(false)
	await sprite2d.animation_finished
	SceneMgmt.load_scene(SceneMgmt.current_level)
	#once dead call ending scene

func toggle_can_attack():
	can_attack = not can_attack

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.normalized()
	velocity = input_direction*SPEED
	
	if Input.is_action_pressed("attack") and can_attack:
		is_shielding = false;
		is_attacking = true
		sprite2d.play("attack")
		await sprite2d.animation_finished
		is_attacking = false
	
	if not is_attacking:
		#if Input.is_action_pressed("shield"):
			#sprite2d.play("shield")
			#is_shielding = true;
		if Input.is_action_pressed("left"):
			sprite2d.flip_h = true
			sprite2d.play("walkRight")
			
		elif Input.is_action_pressed("right"):
			sprite2d.flip_h = false
			sprite2d.play("walkRight")
			
		elif Input.is_action_pressed("down"):
			sprite2d.play("walkForward")
			
		elif Input.is_action_pressed("up"):
			sprite2d.play("walkBackward")
			
		else:
			sprite2d.play("idle")
	else:
		velocity = ZERO_VEC

'''
Handles the event of the player getting shot by a web shot
'''
func shot_by_web() -> void:
	print("got shot")
	#is_detained = true

# when bat hits the player call this
func playerDamaged(value):
	if(is_shielding and shieldHealth > 0):
		shieldHealth -= value
		print(shieldHealth)
	elif(health > 0):
		health -= value
		print(health)
		if(health == 0):
			die()
		sprite2d.play("hurt")
	else:
		die();

func _physics_process(_delta: float) -> void:
	get_input()
	if is_captured_by_ghost:
		velocity = ghost_drag_vector
	move_and_slide()
