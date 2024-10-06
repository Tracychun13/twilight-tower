extends CharacterBody2D

@export var player: CharacterBody2D
@export var hole: Area2D
@export var home: Vector2
const SPEED = 150.0
const HALF_SPEED = 75.0
var is_waiting = true
var has_grabbed = false

func _physics_process(_delta: float) -> void:
	if not is_waiting:
		print("Moving to player")
		var target_direction = (player.position-self.position).normalized()
		if has_grabbed:
			target_direction = (home-self.position).normalized()
			player.position = Vector2()
		velocity = target_direction*SPEED
	else:
		print("Moving back")
		velocity = ((home-self.position).normalized()*HALF_SPEED)
	
	move_and_slide()

func _on_timer_timeout() -> void:
	print("timeout")
	is_waiting = not is_waiting
	
