extends Node2D

@onready var timer = $Timer
@onready var player = $Player
var is_ghost_spawned: bool = false
var ghost_instance = null
var GHOST = preload("res://scenes/ghost.tscn")

func ghost_mechanic() -> void:
	if not is_ghost_spawned and not player.is_in_light:
		ghost_instance = GHOST.instantiate()
		ghost_instance.position = Vector2(220, 112)
		ghost_instance.player_pos = global_position.direction_to(player.position)
		ghost_instance.hole_pos = Vector2(220, 112)
		is_ghost_spawned = true
		#player.is_captured_by_ghost = true
		add_child(ghost_instance)
	elif is_ghost_spawned:
		ghost_instance.queue_free()
		player.is_captured_by_ghost = false
		ghost_instance = null
		is_ghost_spawned = false

func _on_timer_timeout() -> void:
	ghost_mechanic()
