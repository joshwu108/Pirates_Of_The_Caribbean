extends Node2D




func _on_start_pressed() -> void:
	Global._reset_Health()
	get_tree().change_scene_to_file("res://game.tscn")
	pass
