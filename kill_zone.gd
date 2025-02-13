extends Area2D

@onready var timer = $Timer

func _on_body_entered(body) -> void:
	if body == get_tree().get_nodes_in_group("player")[0]:
		_deal_damage(100)
	if get_tree().get_nodes_in_group("player")[0].Health < 0:
		timer.start()
		
func _deal_damage(amount: int) -> void:
	get_tree().get_nodes_in_group("health")[0]._update_health(100)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://death_screen.tscn")
