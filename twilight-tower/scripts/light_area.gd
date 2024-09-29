extends Area2D

@onready var player = $"../Player"

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		print("player exited from light")
		player.toggle_can_attack()


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print("player exited from light")
		player.toggle_can_attack()
