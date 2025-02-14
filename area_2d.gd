extends Area2D

#@onready var enemy = get_tree().get_nodes_in_group("enemy")[0]

#func _on_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Level_2.tscn")
