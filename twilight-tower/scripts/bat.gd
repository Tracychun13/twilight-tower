extends CharacterBody2D


const SPEED = 50.0
var health = 100.0
var playerEntered = false;
@export var player: CharacterBody2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D
@onready var timer = $Timer
@onready var area = $Area2D

func _physics_process(_delta: float) -> void:
	if(playerEntered):
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction * SPEED
		move_and_slide()

func find_hero() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	find_hero()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body == player):
		playerEntered = true;
		print("player is in bat range")
