extends Node

signal on_transition_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
	#animation_player.animation_finished.connect(_on_animation_player_animation_finished)

func transition():
	color_rect.visible = true
	animation_player.play("fade_to_normal")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "fade_to_black":
		#on_transition_finished.emit()
		#animation_player.play("fade_to_normal")
	#elif anim_name == "fade_to_normal":
	color_rect.visible = false
