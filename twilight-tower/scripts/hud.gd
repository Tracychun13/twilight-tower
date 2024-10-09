extends CanvasLayer

@export var player: CharacterBody2D
@onready var shield_health = $shield_health_label 
@onready var curr_level = $current_level_label2
@onready var health_1 = $health_1
@onready var health_2 = $health_2
@onready var health_3 = $health_3
@onready var health_4 = $health_4
@onready var health_5 = $health_5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	curr_level.text = str(SceneMgmt.current_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	shield_health.text = str(player.shieldHealth) + '%'
	if 80 <= player.health and player.health < 100:
		if player.health < 90:
			health_5.region_rect = Rect2(32, 0, 32, 32)
	elif 60 <= player.health and player.health < 80:
		health_5.visible = false
		if player.health < 70:
			health_4.region_rect = Rect2(32, 0, 32, 32)
	elif 40 <= player.health and player.health < 60:
		health_5.visible = false
		health_4.visible = false
		if player.health < 50:
			health_3.region_rect = Rect2(32, 0, 32, 32)
	elif 20 <= player.health and player.health < 40:
		health_5.visible = false
		health_4.visible = false
		health_3.visible = false
		if player.health < 30:
			health_2.region_rect = Rect2(32, 0, 32, 32)
	elif 0 <= player.health and player.health < 20:
		health_5.visible = false
		health_4.visible = false
		health_3.visible = false
		health_2.visible = false
		if player.health < 10:
			health_1.region_rect = Rect2(32, 0, 32, 32)
	elif player.health == 0:
		health_5.visible = false
		health_4.visible = false
		health_3.visible = false
		health_2.visible = false
		health_1.visible = false
		
