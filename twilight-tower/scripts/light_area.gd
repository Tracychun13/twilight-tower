extends Sprite2D

@export var debugEnable: bool
@export var player: CharacterBody2D
@export var ghost: Node2D = null
@export var ghost2: Node2D = null

func _ready() -> void:
	if debugEnable:
		set_process(false)

func _on_attacking_range_body_entered(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()

func _on_attacking_range_body_exited(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()

func _on_ghost_barrier_area_entered(area: Area2D) -> void:
	if ghost and area == ghost.area_ref:
		ghost.toggle_is_waiting()
	
	if ghost2 and area == ghost2.area_ref:
		ghost2.toggle_is_waiting()
