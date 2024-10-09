extends TextureProgressBar

@onready var player = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.spam.connect(update)
	update()
func _process(_delta: float) -> void:
	update()
	
func update():
	value = player.spamCounter
