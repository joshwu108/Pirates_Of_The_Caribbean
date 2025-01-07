extends Node2D



func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")


func _on_start_over_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
