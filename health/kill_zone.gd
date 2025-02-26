extends Area2D

@onready var timer = $Timer
@onready var animated_sprite = $".."
@onready var kill_zone = $CollisionShape2D

@onready var knife_offsets = {
	0: Vector2(-283, 173),
	1: Vector2(-213, -7),  
	2: Vector2(-323, -217),
	3: Vector2(-543, -317),
	4: Vector2(-253, -157),
	5: Vector2(-463, 373),
}

@onready var knife_Rotation = {
	0: 0,  
	1: -33,  
	2: -66,
	3: -113,
	4: -63.7,
	6: -113,
}

func _on_body_entered(body) -> void:
	if body == get_tree().get_nodes_in_group("player")[0]:
		_deal_damage(100)
	if get_tree().get_nodes_in_group("player")[0].Health < 0:
		timer.start()
		
func _deal_damage(amount: int) -> void:
	get_tree().get_nodes_in_group("health")[0]._update_health(100)

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://death_screen.tscn")
	
func _on_animated_sprite_2d_frame_changed() -> void:
	var frame = animated_sprite.frame
	
	if frame in knife_offsets:
		kill_zone.position = knife_offsets[frame]
	
	if frame in knife_Rotation:
		kill_zone.rotation_degrees = knife_Rotation[frame]
