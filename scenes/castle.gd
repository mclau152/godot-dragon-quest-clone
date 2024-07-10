extends Area2D  # Assuming the castle is a StaticBody2D

signal player_entered_castle

func _on_Area2D_body_entered(body):
	if body.name == "player":
		print("enteredddd")
		emit_signal("player_entered_castle")
