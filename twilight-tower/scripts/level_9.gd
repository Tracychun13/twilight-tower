extends Node2D

@onready var spider1 = $spider
@onready var spider2 = $spider2
@onready var bat1 = $bat
@onready var bat2 = $bat2 
@onready var ghost1 = $ghost
@onready var ghost2 = $ghost2
@onready var button = $Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spider1.play("default")
	spider2.play("default")
	ghost1.play("default")
	ghost2.play("default")
	bat1.play("default")
	bat2.play("default")


func _on_button_pressed() -> void:
	SceneMgmt.go_to_level(0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	button.visible = true
