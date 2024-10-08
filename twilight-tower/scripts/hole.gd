extends Area2D

@onready var player = $"../Player"

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		var rng = RandomNumberGenerator.new()
		var new_level = rng.randi_range(1, SceneMgmt.current_level-1)
		print("current_level", SceneMgmt.current_level)
		print("drop player to level", new_level)
		#SceneMgmt.load_scene(new_level)
