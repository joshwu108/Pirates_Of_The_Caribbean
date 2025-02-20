extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const detect_range = 500.0
var health = 200
var frame_timer = 0.0
@onready var sprite = $AnimatedSprite2D
@onready var raycast_front = $RayCast2D

func _ready()-> void:
	var player = get_tree().get_nodes_in_group("damage_material")[0]
	player.connect("bat_entered", Callable(self, "_on_entered_sword"))
	
	add_to_group("humanoid")
	var random = randi_range(0, 4)
	if random == 0:
		sprite.frame = 0
	elif random == 1:
		sprite.frame = 4
	elif random == 2:
		sprite.frame = 8
	elif random == 3:
		sprite.frame = 12
	elif random == 4:
		sprite.frame == 16
	
func _on_entered_sword(enemy):
	if enemy == self:
		health -= 100
	if health <= 0:
		queue_free()
	
func _process(delta: float) -> void:
	#Jumping
	var jumps = get_tree().get_nodes_in_group("jump")
	for jump in jumps:
		if not jump.is_connected("jump", Callable(self, "_on_jump")):
			jump.connect("jump", Callable(self, "_on_jump"))
	
	frame_timer += delta#time since the previous frame
	if frame_timer >= 0.2:#rate at which the frames are changing
		if sprite.frame in range(0, 3):  
			sprite.frame = 0 + ((sprite.frame + 1) % 4)  
		elif sprite.frame in range(4, 7):
			sprite.frame = 4 + ((sprite.frame - 4 + 1) % 4)  
		elif sprite.frame in range(8, 11):
			sprite.frame = 8 + ((sprite.frame - 8 + 1) % 4) 
		elif sprite.frame in range(12, 15):
			sprite.frame = 12 + ((sprite.frame - 12 + 1) % 4)  
		elif sprite.frame in range(16,19):
			sprite.frame = 16 + ((sprite.frame - 16 + 1) % 4)  
		frame_timer = 0.0
	
	
func _on_jump(body) -> void:
	if body == self:
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	var player = get_tree().get_nodes_in_group("player")[0]
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#jump if colliding with a stairstep etc
	if raycast_front.is_colliding():
		velocity.y = JUMP_VELOCITY
		
	var distance = self.global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	
	#detecting the player
	if distance < detect_range:
		velocity.x = SPEED * direction.x
	else:
		velocity.x = 0
	
	#changing directions
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else :
		$AnimatedSprite2D.flip_h = false

	move_and_slide()
