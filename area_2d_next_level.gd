extends Area2D

@onready var player = get_tree().get_nodes_in_group("player")[0]


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		get_tree().change_scene_to_file("res://level_4.tscn")
