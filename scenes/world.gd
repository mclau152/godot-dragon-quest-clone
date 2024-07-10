extends Node2D

#var inside_castle_scene = preload("res://insidecastle.tscn")

func _ready():
	var castle = $castle  # Adjust this path if necessary
	castle.player_entered_castle.connect(_on_player_entered_castle)

func _on_player_entered_castle():
	get_tree().change_scene_to_file("res://Scenes/insidecastle.tscn")
