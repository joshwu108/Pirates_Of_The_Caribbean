extends Area2D

@onready var timer = $Timer

func _on_body_entered(body) -> void:
	print("you died")
	timer.start()
	



func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://death_screen.tscn")
