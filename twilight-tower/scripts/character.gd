extends CharacterBody2D


const SPEED = 80.0
const ZERO_VEC = Vector2(0.0, 0.0)
var is_attacking = false
var is_in_light = false
var can_attack = false
var is_captured_by_ghost = false
@onready var sprite2d = $AnimatedSprite2D

func die():
	sprite2d.play("die")
	set_physics_process(false)
	set_process_input(false)
	await sprite2d.animation_finished
	get_tree().reload_current_scene()

func toggle_can_attack():
	can_attack = not can_attack

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.normalized()
	velocity = input_direction*SPEED
	
	if Input.is_action_pressed("attack") and can_attack:
		is_attacking = true
		sprite2d.play("attack")
		await sprite2d.animation_finished
		is_attacking = false
	
	if not is_attacking:
		if Input.is_action_pressed("left"):
			sprite2d.flip_h = true
			sprite2d.play("walk")
		elif Input.is_action_pressed("right"):
			sprite2d.flip_h = false
			sprite2d.play("walk")
		elif Input.is_action_pressed("down") or Input.is_action_pressed("up"):
			sprite2d.play("walk")
		else:
			sprite2d.play("idle")
	else:
		velocity = ZERO_VEC

func _physics_process(_delta: float) -> void:
	get_input()
	if is_captured_by_ghost:
		velocity = ZERO_VEC
	move_and_slide()
