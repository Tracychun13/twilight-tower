extends Area2D

@export var player: CharacterBody2D
@export var bat1: CharacterBody2D
@export var bat2: CharacterBody2D
@onready var warning = $CanvasLayer/warning

func _ready() -> void:
	warning.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if is_instance_valid(bat1) and bat1.isAlive:
			warning.visible = true
			
		elif is_instance_valid(bat2) and bat2.isAlive:
			warning.visible = true

		else:
			SceneMgmt.change_level()
