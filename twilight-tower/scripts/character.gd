extends CharacterBody2D


const SPEED = 120.0
@onready var sprite2d = $AnimatedSprite2D

func die():
	sprite2d.play("die")
	set_physics_process(false)	
	set_process_input(false)
	await sprite2d.animation_finished
	get_tree().reload_current_scene()

func get_input():
	if Input.is_action_pressed("down") or Input.is_action_pressed("right") \
		or Input.is_action_pressed("left") or Input.is_action_pressed("up"):
		sprite2d.animation = "walk"
	else:
		sprite2d.animation = "idle"
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.normalized()
	velocity = input_direction*SPEED
	var flip_character = velocity.x < 0
	sprite2d.flip_h = flip_character

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
