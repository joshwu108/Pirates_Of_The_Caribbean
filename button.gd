extends Button


func _process(delta):
	# Check if the 'E' key is pressed
	if Input.is_action_just_pressed("ui_interact"):
		_on_pressed()



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://level_3.tscn") # Replace with function body.
