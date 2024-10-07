extends Node2D

const SPEED = 100

var player: CharacterBody2D
var direction: Vector2
var spawn_position: Vector2
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_position
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = -SPEED*direction
	self.translate(velocity*delta)
	
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
	if body == player:
		player.shot_by_web()
