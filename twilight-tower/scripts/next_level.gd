extends Area2D

@export var player: CharacterBody2D
@export var sceneManager: Node
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		sceneManager.change_level()
