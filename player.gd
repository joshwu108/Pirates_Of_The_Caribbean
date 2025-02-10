extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

var is_facing_right = true  

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Handle attack.
	if Input.is_action_just_pressed('shift'):
		on_attack()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if direction > 0 and not is_facing_right:
			$AnimatedSprite2D.flip_h = false 
			$AnimatedSprite2D2.flip_h = false 
			is_facing_right = true
		elif direction < 0 and is_facing_right:
			$AnimatedSprite2D.flip_h = true 
			$AnimatedSprite2D2.flip_h = true
			is_facing_right = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Level_2.tscn")

func on_attack() -> void:
	$AnimatedSprite2D.visible = false
	$AnimatedSprite2D2.visible = true
	$AnimatedSprite2D2.play('default')
	
	await $AnimatedSprite2D2.animation_finished
	$AnimatedSprite2D2.visible = false
	$AnimatedSprite2D.visible = true
