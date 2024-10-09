extends Node

@onready var tran_screen = $TransitionScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tran_screen.transition()
