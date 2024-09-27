extends CharacterBody2D


const SPEED = 120.0
var is_attacking = false
@onready var sprite2d = $AnimatedSprite2D

func die():
	sprite2d.play("die")
	set_physics_process(false)
	set_process_input(false)
	await sprite2d.animation_finished
	get_tree().reload_current_scene()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction.normalized()
	velocity = input_direction*SPEED
	if Input.is_action_pressed("down") or Input.is_action_pressed("right") \
		or Input.is_action_pressed("left") or Input.is_action_pressed("up"):
		sprite2d.play("walk")
	#elif Input.is_action_pressed("attack"):
		#sprite2d.play("attack")
	else:
		sprite2d.play("idle")

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
