extends Node2D

@export var debug_enable: bool
@export var player: CharacterBody2D
@onready var spit = load("res://scenes/web_spit.tscn")
@onready var sprite2d = $AnimatedSprite2D
var can_shoot = false

func _ready() -> void:
	if debug_enable:
		set_process(false)

func shoot_web() -> void:
	var web = spit.instantiate()
	web.direction = (global_position-player.position).normalized()
	web.spawn_position = self.position
	web.player = player
	get_tree().current_scene.get_child(0).add_child.call_deferred(web)
	sprite2d.play("shoot")
	

func _process(_delta: float) -> void:
	look_at(player.position)


func _on_activation_region_body_entered(body: Node2D) -> void:
	if body == player :
		can_shoot = true


func _on_activation_region_body_exited(body: Node2D) -> void:
	if body == player:
		shoot_web()
		can_shoot = false


func _on_timer_timeout() -> void:
	if can_shoot and not player.is_detained:
		shoot_web()
	
