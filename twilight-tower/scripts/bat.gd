extends CharacterBody2D


const SPEED = 50.0
var health = 100.0
@export var player: CharacterBody2D
@onready var navigation_agent_enemy_1: NavigationAgent2D = $NavigationAgent2D
@onready var timer = $Timer

func _physics_process(_delta: float) -> void:
	find_hero()
	if navigation_agent_enemy_1.is_navigation_finished():
		return
	var next_pos = navigation_agent_enemy_1.get_next_path_position()
	var direction := global_position.direction_to(next_pos)
	
	velocity = direction*SPEED
	move_and_slide()

func find_hero() -> void:
	navigation_agent_enemy_1.target_position = player.global_position

func _on_timer_timeout() -> void:
	find_hero()
