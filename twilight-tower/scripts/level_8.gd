extends Node

@onready var tran_screen = $TransitionScreen
@onready var hole = $hole
@onready var player = $Player
@onready var hole2 = $hole2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tran_screen.transition()
	if randf() > 0.5:
		hole.winningHole = true
	else:
		hole2.winningHole = true
