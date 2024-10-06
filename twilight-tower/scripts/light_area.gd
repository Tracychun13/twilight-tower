extends Area2D

@export var player: CharacterBody2D
@export var bat: CharacterBody2D
@export var ghost: Node2D

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()
		player.modulate = Color(1 - player.modulate.r, 1 - player.modulate.g, 1 - player.modulate.b, player.modulate.a)
	if body == bat:
		bat.modulate = Color(1 - bat.modulate.r, 1 - bat.modulate.g, 1 - bat.modulate.b, bat.modulate.a)
		
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.toggle_can_attack()
		player.modulate = Color(1 - player.modulate.r, 1 - player.modulate.g, 1 - player.modulate.b, player.modulate.a)
	if body == bat:
		bat.modulate = Color(1 - bat.modulate.r, 1 - bat.modulate.g, 1 - bat.modulate.b, bat.modulate.a)
	if body == ghost:
		print("ghost entered")
		ghost.is_waiting = true


		
