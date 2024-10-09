extends Area2D

@export var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		SceneMgmt.change_level()
		#TransitionScreen.transition()
		#await TransitionScreen.on_transition_finished
		#sceneManager.
