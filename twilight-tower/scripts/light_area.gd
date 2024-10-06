extends Area2D

@export var player: CharacterBody2D
@export var bat: CharacterBody2D
@export var ghost: Node2D

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()
		
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()
	if body == ghost:
		print("ghost entered")
		ghost.is_waiting = true


		
