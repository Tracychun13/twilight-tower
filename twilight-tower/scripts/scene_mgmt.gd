extends Node

var current_level = 0

enum Level{
	LEVEL_MAIN=0,
	LEVEL_ONE=1,
	LEVEL_TWO=2,
	LEVEL_THREE=3,
	LEVEL_FOUR=4,
	LEVEL_FIVE=5,
	LEVEL_SIX=6,
	LEVEL_SEVEN=7,
	LEVEL_EIGHT=8,
	LEVEL_NINE=9,
	LEVEL_TEN=10,
}

const levels = {
	Level.LEVEL_ONE:"res://scenes/game_level_1.tscn",
	Level.LEVEL_TWO:"res://scenes/game_level_2.tscn",
	Level.LEVEL_THREE:"res://scenes/game_level_3.tscn",
	Level.LEVEL_FOUR:"res://scenes/game_level_4.tscn",
	Level.LEVEL_FIVE:"res://scenes/game_level_5.tscn",
	Level.LEVEL_SIX:"res://scenes/game_level_6.tscn",
	Level.LEVEL_SEVEN:"res://scenes/game_level_7.tscn",
	Level.LEVEL_EIGHT:"res://scenes/game_level_8.tscn",
	Level.LEVEL_NINE:"res://scenes/game_level_9.tscn",
	Level.LEVEL_TEN:"res://scenes/game_level_10.tscn",
	
}

func _ready() -> void:
	load_scene(Level.LEVEL_ONE)
	
func load_scene(scene: Level) -> void:
	if get_child_count():
		get_child(0).queue_free()
	var new_scene = load(levels[scene])
	add_child(new_scene.instantiate())

func change_level(from: Level, to: Level) -> void:
	pass
