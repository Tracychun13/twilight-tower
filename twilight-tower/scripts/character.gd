extends CharacterBody2D

const SPEED = 80.0
const ZERO_VEC = Vector2(0.0, 0.0)
var is_attacking = false
var is_in_light = false
var can_attack = false
var is_captured_by_ghost = false
var health = 100;
var shieldHealth = 100;
var is_shielding = false
@onready var sprite2d = $AnimatedSprite2D

func die():
	sprite2d.play("die")
	set_physics_process(false)
	set_process_input(false)
	await sprite2d.animation_finished
	get_tree().reload_current_scene()
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
		if Input.is_action_pressed("left"):
			sprite2d.flip_h = true
			sprite2d.play("walkRight")
			is_shielding = false;
		elif Input.is_action_pressed("right"):
			sprite2d.flip_h = false
			sprite2d.play("walkRight")
			is_shielding = false;
		elif Input.is_action_pressed("down"):
			sprite2d.play("walkForward")
			is_shielding = false;
		elif Input.is_action_pressed("up"):
			sprite2d.play("walkBackward")
			is_shielding = false;
		#elif Input.is_action_pressed("shield"):
			#sprite2d.play("shield")
			#is_shielding = true;
		else:
			sprite2d.play("idle")
	else:
		velocity = ZERO_VEC

# when bat hits the player call this
func playerDamaged(value):
	if(is_shielding):
		shieldHealth - value;
	elif(not(health <= 0)):
		health - value; 
		sprite2d.play("hurt")
	else:
		die();

func _physics_process(_delta: float) -> void:
	get_input()
	if is_captured_by_ghost:
		velocity = ZERO_VEC
	move_and_slide()
