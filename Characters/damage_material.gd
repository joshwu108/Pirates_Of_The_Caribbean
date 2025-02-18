extends Area2D

@onready var knife_offsets = {
	0: Vector2(254, 45),
	1: Vector2(115, -204),  
	2: Vector2(-92, -295),
	3: Vector2(-393, -250),
	4: Vector2(-34, -318),
	5: Vector2(300, 420),
	6: Vector2(323, 226),
}

@onready var knife_Rotation = {
	0: 42,  
	1: 3,  
	2: -33,
	3: -69,
	4: -42,
	5: -108,
	6: 41.5,
}

func _on_body_entered(body: Node2D) -> void:
	if get_tree().get_nodes_in_group("enemy").size() > 0 && body == get_tree().get_nodes_in_group("enemy")[0]:
		get_tree().get_nodes_in_group("enemy")[0].health -= 100
		print("damage_done")
	elif get_tree().get_nodes_in_group("bats").size() > 0 && body == get_tree().get_nodes_in_group("bats")[0]:
		get_tree().get_nodes_in_group("bats")[0].health -= 100
		print("stuff")
