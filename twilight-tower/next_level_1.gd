extends Area2D

@export var player: CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print("change level")
		get_tree().change_scene_to_file("res://scenes/game_level_2.tscn")
