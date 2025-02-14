extends Area2D

@onready var timer = $Timer




func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().get_nodes_in_group("player")[0]:
		timer.start()
		
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://death_screen.tscn")
