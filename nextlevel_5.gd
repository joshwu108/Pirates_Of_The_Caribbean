extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().get_nodes_in_group("player")[0]:
			get_tree().change_scene_to_file("res://level_6.tscn") # Replace with function body.
