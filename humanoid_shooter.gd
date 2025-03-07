extends CharacterBody2D


const detect_range = 500.0
var health = 200
var shoot_cooldown = 5.0
var last_shot_time = 0.0
var sprite_type = 0
@onready var arrow_scene = preload("res://Characters/arrow.tscn")
@onready var sprite = $AnimatedSprite2D
@onready var raycast_front = $RayCast2D
@onready var timer = $Timer

func _ready()-> void:
	var player = get_tree().get_nodes_in_group("damage_material")[0]
	player.connect("bat_entered", Callable(self, "_on_entered_sword"))
	sprite.play("idle")

	
	add_to_group("humanoid_shooter")
	var random = randi_range(0, 3)
	if random == 0:
		sprite.play("idle_1")
	elif random == 1:
		sprite_type = 1
		sprite.play("idle_2")
	elif random == 2:
		sprite_type = 2
		sprite.play("idle_3")
	


func _on_entered_sword(enemy):
	if enemy == self:
		health -= 100
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:

	var player = get_tree().get_nodes_in_group("player")[0]
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		
	var distance = self.global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	if distance < detect_range:
		change_sprite()
	else:
		change_back()
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else :
		$AnimatedSprite2D.flip_h = false
		
		
func change_sprite():
	if sprite_type == 0:
		sprite.play("shoot_1")
	elif sprite_type == 1:
		sprite.play("shoot_2")
	elif sprite_type == 2:
		sprite.play("shoot_3")
		

func change_back():
	if sprite_type == 0:
		sprite.play("idle_1")
	elif sprite_type == 1:
		sprite.play("idle_2")
	elif sprite_type == 2:
		sprite.play("idle_3")
		

func shoot_arrow():
	var player = get_tree().get_nodes_in_group("player")[0]
	# Create the arrow instance
	var arrow = arrow_scene.instantiate()
	get_parent().add_child(arrow)
	if $AnimatedSprite2D.flip_h == true:
		arrow.position.x = position.x -35
		arrow.position.y = position.y 
		
	elif $AnimatedSprite2D.flip_h == false:
		arrow.position.x = position.x + 35
		arrow.position.y = position.y 



func _on_timer_timeout() -> void:
	var player = get_tree().get_nodes_in_group("player")[0]
	var distance = self.global_position.distance_to(player.global_position)
	if distance < detect_range:
		shoot_arrow()
		
	
