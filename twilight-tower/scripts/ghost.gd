extends Node2D

@export var player: CharacterBody2D
@export var hole: Area2D
@export var home: Vector2
var velocity = Vector2()
const SPEED = 125.0
const HALF_SPEED = 75.0
var is_waiting = true
var has_grabbed = false

func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	if not is_waiting:
		var target_direction = (player.position-self.position).normalized()
		if has_grabbed:
			target_direction = (home-self.position).normalized()
		velocity = target_direction*SPEED
	else:
		velocity = ((home-self.position).normalized()*HALF_SPEED)
	
	self.translate(velocity*delta)

func _on_timer_timeout() -> void:
	if is_waiting and randf() > 0.4:
		is_waiting = false
	elif not is_waiting:
		is_waiting = true		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player.is_captured_by_ghost = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player.is_captured_by_ghost = false
