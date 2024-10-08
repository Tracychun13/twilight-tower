extends CharacterBody2D;

const SPEED = 80.0
const ZERO_VEC = Vector2(0.0, 0.0)
const spamGoal = 100
var ghost_drag_vector = Vector2(0.0, 0.0)
var can_attack = false
var is_detained = false
var is_captured_by_ghost = false
var health = 100
var shieldHealth = 100
var spamCounter = 0
var is_shielding = false
var is_attacking = false
var landedHit = false
var sprite_flipped
var time_since_last_damage: float = 0.0
var damage_interval = 0.5
@onready var timer = $Timer
@onready var sprite2d = $AnimatedSprite2D
@onready var bat = $"../Bat"
@onready var collision = $CollisionShape2D

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
	if is_detained:
		if Input.is_action_just_pressed("detained"):
			timer.start()
			detained_spamming()
	if Input.is_action_just_pressed("attack") and can_attack and not is_detained:
		is_shielding = false;
		is_attacking = true
		sprite2d.play("attack")
		await sprite2d.animation_finished
		is_attacking = false
	
	if Input.is_action_pressed("shield") and not is_detained:
		is_shielding = true;
	else:
		is_shielding = false;
	if not is_attacking and not is_detained:
		
		if Input.is_action_pressed("left"):
			sprite2d.flip_h = true
			if(is_shielding):
				sprite2d.play("shieldingRight")
			else:
				sprite2d.play("walkRight")
			
		elif Input.is_action_pressed("right"):
			sprite2d.flip_h = false
			if(is_shielding):
				sprite2d.play("shieldingRight")
			else:
				sprite2d.play("walkRight")
			
		elif Input.is_action_pressed("down"):
			if(is_shielding):
				sprite2d.play("shieldingForward")
			else:
				sprite2d.play("walkForward")
		elif Input.is_action_pressed("up"):
			sprite2d.play("walkBackward")
		else:
			if(is_shielding):
				sprite2d.play("shieldingIdle")
			else: 
				sprite2d.play("idle")
	else:
		velocity = ZERO_VEC

'''
Handles the event of the player getting shot by a web shot
'''
func shot_by_web() -> void:
	print("got shot")
	is_detained = true

# when bat hits the player call this
func playerDamaged(value):
	sprite2d.play("hurt")
	if(is_shielding and shieldHealth > 0):
		shieldHealth -= value
		print("Shield Health: ", shieldHealth)
	elif(health > 0):
		health -= value
		print("Health: ", health)
		if(health == 0):
			die()
	else:
		die();

func detained_spamming() -> void:
	spamCounter+= 10;
	print(spamCounter);
	if(spamCounter == spamGoal):
		timer.stop()
		print("player is free")
		is_detained = false
		spamCounter = 0


func _physics_process(_delta: float) -> void:
	get_input()
	if is_captured_by_ghost:
		velocity = ghost_drag_vector
	if(is_detained):
		sprite2d.play("detained")
	move_and_slide()


func _on_timer_timeout() -> void:
	spamCounter = 0


func _on_attacking_hitbox_body_entered(body: Node2D) -> void:
	if body == bat and is_attacking:
		landedHit = true;
		if(bat.isAlive):
			bat.batDamaged(20)
	else:
		landedHit = false
