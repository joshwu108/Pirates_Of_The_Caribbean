extends Area2D

signal jump()

func _ready():
	add_to_group("jump")
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node2D) -> void:
	if get_tree().get_nodes_in_group("enemy").size() > 0 && body == get_tree().get_nodes_in_group("enemy")[0]:
		emit_signal("jump")
		print("jumped")
		
