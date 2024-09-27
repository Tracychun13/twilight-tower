extends CharacterBody2D


const SPEED = 120.0
@onready var sprite2d = $AnimatedSprite2D

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.normalized()
	velocity = input_direction*SPEED
	var flip_character = velocity.x < 0
	sprite2d.flip_h = flip_character

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	
