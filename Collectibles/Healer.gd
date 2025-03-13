extends Area2D

@onready var sprite = $AnimatedSprite2D
var frame_timer = 0.0  # Timer for changing frames

func _ready() -> void:
	sprite.visible = true
	if get_tree().current_scene.scene_file_path == "res://game.tscn" || get_tree().current_scene.scene_file_path == "res://Level_2.tscn":
		var random_num = randi_range(0, 1)
		if random_num == 0:
			$AnimatedSprite2D.frame = 3
		else:
			$AnimatedSprite2D.frame = 7
	elif get_tree().current_scene.scene_file_path == "res://level3":
		var random_num = randi_range(0, 3)
		$AnimatedSprite2D.frame = random_num

func _process(delta: float) -> void:
	frame_timer += delta#time since the previous frame
	if frame_timer >= 0.2:#rate at which the frames are changing
		if sprite.frame in range(3, 7):  
			sprite.frame = 3 + ((sprite.frame - 3 + 1) % 4)  # Loops between 3-6
		elif sprite.frame in range(7, 11):
			sprite.frame = 7 + ((sprite.frame - 7 + 1) % 4)  # Loops between 7-10
		frame_timer = 0.0

func _on_body_entered(body: Node2D) -> void:
	if body == get_tree().get_nodes_in_group("player")[0]:
		get_tree().get_nodes_in_group("health")[0]._update_health(-25)
		$AnimatedSprite2D.visible = false
		queue_free()#remove item from scene
