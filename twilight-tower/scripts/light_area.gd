extends Sprite2D

@export var player: CharacterBody2D
@export var bat: CharacterBody2D
@export var ghost: Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area == ghost.area_ref:
		ghost.toggle_is_waiting()
