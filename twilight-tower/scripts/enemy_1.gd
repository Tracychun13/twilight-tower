extends CharacterBody2D


const SPEED = 40.0
@onready var player = $"../Player"
@onready var navigation_agent_enemy_1: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	find_hero()

func _physics_process(_delta: float) -> void:
	if navigation_agent_enemy_1.is_navigation_finished():
		return
	var next_pos = navigation_agent_enemy_1.get_next_path_position()
	var direction := global_position.direction_to(next_pos)
	
	print(next_pos)
	velocity = direction*SPEED
	move_and_slide()
	
	find_hero()

func find_hero() -> void:
	navigation_agent_enemy_1.target_position = player.global_position
	
