extends CharacterBody2D

@onready var player = $"../Player"
@onready var hole = $"../hole"
const SPEED = 250.0
var can_move = false
var has_grabbed = false

func _ready() -> void:
	pass
	
func _physics_process(_delta) -> void:
	if not has_grabbed:
		velocity = SPEED*player.position
	else:
		velocity = (SPEED/3)*hole.position
	move_and_slide()
