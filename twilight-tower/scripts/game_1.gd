extends Node2D

@onready var timer = $Timer
@onready var player = $Player
var is_ghost_spawned: bool = false
@onready var hole = $hole
@onready var ghost = $Ghost
