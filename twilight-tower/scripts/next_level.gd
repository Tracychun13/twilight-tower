extends Area2D

@export var player: CharacterBody2D
@export var bat1: CharacterBody2D
@export var bat2: CharacterBody2D
@onready var warning = $CanvasLayer/warning

func _ready() -> void:
	warning.visible = false
	
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if bat1.isAlive or bat2.isAlive:
			warning.visible = true
			#SceneMgmt.go_to_level(SceneMgmt.current_level)
		else:
			SceneMgmt.change_level()
