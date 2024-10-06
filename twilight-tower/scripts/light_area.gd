extends Area2D

@onready var player = $"../Player"
@onready var bat = $"../Bat"
func _on_body_exited(body: Node2D) -> void:
	# TODO add invert player color
	if body == player:
		player.toggle_can_attack()
		player.is_in_light = false
		player.modulate = Color(1 - player.modulate.r, 1 - player.modulate.g, 1 - player.modulate.b, player.modulate.a)
	if body == bat:
		bat.modulate = Color(1 - bat.modulate.r, 1 - bat.modulate.g, 1 - bat.modulate.b, bat.modulate.a)
		
		#bat.modulate = Color.WHITE
		
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.is_in_light = true
		player.toggle_can_attack()
		player.modulate = Color(1 - player.modulate.r, 1 - player.modulate.g, 1 - player.modulate.b, player.modulate.a)
	if body == bat:
		bat.modulate = Color(1 - bat.modulate.r, 1 - bat.modulate.g, 1 - bat.modulate.b, bat.modulate.a)
		#bat.texture = load("res://assets/ghost_assets/ghost.png")
		


		
