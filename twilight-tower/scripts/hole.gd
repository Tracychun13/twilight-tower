extends Area2D

@onready var player = $"../Player"
@export var winningHole: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if not winningHole:
			var rng = RandomNumberGenerator.new()
			var new_level = rng.randi_range(1, SceneMgmt.current_level-1)
			print("current_level", SceneMgmt.current_level, " new_level", new_level)
			SceneMgmt.go_to_level(new_level)
		else:
			SceneMgmt.go_to_level(9)
