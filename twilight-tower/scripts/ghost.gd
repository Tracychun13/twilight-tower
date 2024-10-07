extends Node2D

@export var debug_enable: bool
@export var player: CharacterBody2D
@export var hole: Area2D
@export var home: Vector2
var area_ref: Area2D
var ghost_timer: Timer
var velocity = Vector2()
const SPEED = 100.0
const HALF_SPEED = 75.0
var is_waiting = true
var has_grabbed = false

func _ready() -> void:
	area_ref = $Area2D
	ghost_timer = $Timer
	if debug_enable:
		set_process(false)
	else:
		set_process(true)

func _process(delta: float) -> void:
	if not is_waiting and has_grabbed:
		var target_direction = (home-self.position).normalized()
		player.ghost_drag_vector = velocity
		velocity = target_direction*HALF_SPEED
	elif not is_waiting and not has_grabbed:
		var target_direction = (player.position-self.position).normalized()	
		velocity = target_direction*SPEED
	else:
		velocity = ((home-self.position).normalized()*HALF_SPEED)
	
	self.translate(velocity*delta)

func _on_timer_timeout() -> void:
	if is_waiting and randf() > 0.4:
		toggle_is_waiting()
	elif not is_waiting:
		toggle_is_waiting()

func toggle_is_waiting() -> void:
	is_waiting = not is_waiting

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		has_grabbed = true
		player.is_captured_by_ghost = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		has_grabbed = false
		player.is_captured_by_ghost = false
