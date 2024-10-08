extends CharacterBody2D

const SPEED = 50.0
var health = 100
var playerEnteredRange = false
var damager = 10
var isPlayerTouching = false
var time_since_last_damage: float = 0.0
var damage_interval = 1.0
var isAlive = true
@export var debug_enable: bool
@export var player: CharacterBody2D
@onready var nav_agent:= $NavigationAgent2D as NavigationAgent2D
@onready var timer = $Timer
@onready var playerScript = $"../Player"



func _ready() -> void:
	if debug_enable:
		set_process(false)

func _physics_process(_delta: float) -> void:
	if(playerEnteredRange):
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction * SPEED
		move_and_slide()
	if(isPlayerTouching):
		if(time_since_last_damage >= damage_interval):
			#playerScript.playerDamaged(10)
			print("Damaging player")
			time_since_last_damage = 0.0
		time_since_last_damage += _delta
	if(health == 0):
		self.queue_free()

func find_hero() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	find_hero()

func batDamaged(value) -> void:
	if health > 0:
		health-= value
		print("BAT HEALTH: ", health)
	
	
#Enter the range bat will start chasing
func _on_range_entered(body: Node2D) -> void:
	if(body == player):
		playerEnteredRange = true;
		print("player is in bat range, Bat will follow!")


#something collided with bat
func _on_collision_area_entered(body: Node2D) -> void:
	if(body == player):
		print("Player entered damage area")
		isPlayerTouching = true
		playerScript.playerDamaged(10)
		time_since_last_damage = 0.0


func _on_collision_area_exited(body: Node2D) -> void:
	if(body == player):
		isPlayerTouching = false;
