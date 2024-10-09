extends Control

@onready var sprite2d = $AnimatedSprite2D
@onready var player = $Player
@onready var buttons = $VBoxContainer
@onready var startDirections = $StartDirections
@onready var arrow = $StartDirections/arrow
@onready var controls = $ControlsDirections
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.can_move = false
	startDirections.visible = false
	controls.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite2d.play("default")
	if(startDirections.visible):
		arrow.play("default")
	if(controls.visible):
		controls.play("default")


func _on_start_button_pressed() -> void:
	player.can_move = true
	buttons.queue_free()
	startDirections.visible = true
	


func _on_controls_pressed() -> void:
	controls.visible = true


func _on_exit_button_pressed() -> void:
	controls.visible = false
	
