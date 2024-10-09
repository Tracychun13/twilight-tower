extends TextureProgressBar

@onready var bat = $".."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bat.healthChanged.connect(update)
	update()

func update():
	value = bat.health
