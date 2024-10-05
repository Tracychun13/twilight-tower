extends CharacterBody2D


const SPEED = 250.0
var is_summoned = false
var player_pos = Vector2(0.0, 0.0)
var hole_pos = Vector2(0.0, 0.0)
var has_grabbed = false
func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if not has_grabbed:
		velocity = SPEED*player_pos
	else:
		velocity = (SPEED/3)*hole_pos
	move_and_slide()
