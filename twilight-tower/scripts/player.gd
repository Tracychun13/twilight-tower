extends CharacterBody2D;

var SPEED = 75.0
const ZERO_VEC = Vector2(0.0, 0.0)
const spamGoal = 100
var ghost_drag_vector = Vector2(0.0, 0.0)
var can_attack = false
var is_detained = false
var is_captured_by_ghost = false
var health = 100
var shieldHealth = 100
var spamCounter = 0
var bat_is_in_hitbox = false
var bat2_is_in_hitbox = false
var is_shielding = false
var is_attacking = false
var can_move = true
var can_attack_again = true
var time_since_last_damage: float = 0.0
var damage_interval = 0.5
var can_take_damage = false
@export var speed_multiplier: float = 1.0
@onready var player_root = $"."
@onready var timer = $SpamTimer
@onready var attack_timer = $AttackTimer
@onready var sprite2d = $AnimatedSprite2D
@onready var bat = $"../Bat"
@onready var bat2 = $"../Bat2"
@onready var collision = $CollisionShape2D

func _ready() -> void:
	SPEED *= speed_multiplier

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
	is_attacking = false
	if Input.is_action_pressed("attack") and can_attack and not is_detained:
		if bat_is_in_hitbox and bat.isAlive and can_attack_again:
			can_attack_again = false
			attack_timer.start()
			print("Attacking bat")
			bat.batDamaged(20)
		if bat2_is_in_hitbox and bat2.isAlive and can_attack_again:
			can_attack_again = false
			attack_timer.start()
			print("Attacking bat")
			bat2.batDamaged(20)
		is_shielding = false
		is_attacking = true
		sprite2d.play("attack")
		await sprite2d.animation_finished
	if Input.is_action_pressed("shield") and not is_detained:
		is_shielding = true;
	else:
		is_shielding = false;
	if not is_attacking and not is_detained:
		
		if Input.is_action_pressed("left"):
			sprite2d.scale.x = -1
			if(is_shielding):
				sprite2d.play("shieldingRight")
			else:
				sprite2d.play("walkRight")
			
		elif Input.is_action_pressed("right"):
			sprite2d.scale.x = 1
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
			sprite2d.scale.x = 1
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
	if can_move:
		get_input()
	if is_captured_by_ghost:
		velocity = ghost_drag_vector
	if bat_is_in_hitbox and can_take_damage:
		playerDamaged(10)
	if(is_detained):
		sprite2d.play("detained")
	move_and_slide()


func _on_timer_timeout() -> void:
	spamCounter = 0


func _on_attacking_hitbox_body_entered(body: Node2D) -> void:
	if body == bat:
		print('bat entered attack hitbox')
		bat_is_in_hitbox = true
	if body == bat2:
		print('bat entered attack hitbox')
		bat2_is_in_hitbox = true

func _on_attacking_hitbox_body_exited(body: Node2D) -> void:
	if body == bat:
		print('bat left attack hitbox')
		bat_is_in_hitbox = false
	if body == bat2:
		print('bat left attack hitbox')
		bat2_is_in_hitbox = false


func _on_attack_timer_timeout() -> void:
	can_attack_again = true
	attack_timer.stop()
