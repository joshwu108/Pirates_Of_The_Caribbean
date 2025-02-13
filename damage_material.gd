extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().get_nodes_in_group("enemy")[0]:
		get_tree().get_nodes_in_group("enemy")[0].health -= 100
		print("damage_done")
