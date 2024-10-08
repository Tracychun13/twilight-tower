extends Node

var current_level = 1
var curr_scene: Node = null
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

const id_to_level = {
	0:Level.LEVEL_MAIN,
	1:Level.LEVEL_ONE, 
	2:Level.LEVEL_TWO, 
	3:Level.LEVEL_THREE,
	4:Level.LEVEL_FOUR,
	5:Level.LEVEL_FIVE,
	6:Level.LEVEL_SIX,
	7:Level.LEVEL_SEVEN,
	8:Level.LEVEL_EIGHT,
	9:Level.LEVEL_NINE,
	10:Level.LEVEL_TEN
}

const levels = {
	Level.LEVEL_MAIN:"res://scenes/level_main.tscn",
	Level.LEVEL_ONE:"res://scenes/level_1.tscn",
	Level.LEVEL_TWO:"res://scenes/level_2.tscn",
	Level.LEVEL_THREE:"res://scenes/level_3.tscn",
	Level.LEVEL_FOUR:"res://scenes/level_4.tscn",
	Level.LEVEL_FIVE:"res://scenes/level_5.tscn",
	Level.LEVEL_SIX:"res://scenes/level_6.tscn",
	Level.LEVEL_SEVEN:"res://scenes/level_7.tscn",
	Level.LEVEL_EIGHT:"res://scenes/level_8.tscn",
	Level.LEVEL_NINE:"res://scenes/level_9.tscn",
	Level.LEVEL_TEN:"res://scenes/level_10.tscn",
}

func _ready() -> void:
	load_scene(current_level)

func load_scene(scene: Level) -> void:
	var new_scene = load(levels[scene])
	if curr_scene:
		curr_scene.queue_free()
	curr_scene = new_scene.instantiate()
	get_tree().root.get_child(1).add_child.call_deferred(curr_scene)

func go_to_level(levelId: int):
	#if levelId == current_level and levelId > 1:
		#levelId -= 1
	var targetLevel = id_to_level[levelId]
	load_scene(targetLevel)
	
func change_level():
	current_level += 1
	print("switching to level ", current_level)
	load_scene(current_level)
