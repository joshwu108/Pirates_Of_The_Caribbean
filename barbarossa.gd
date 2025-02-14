extends CharacterBody2D

const SPEED = 250.0
const attack_range = 50
const detect_range = 600
const JUMP_VELOCITY = -450
@onready var raycast = $RayCast2D
@onready var raycast_front = $RayCast2D2
@export var health = 500
@onready var killzone = $AnimatedSprite2D/KillZone

func _ready() -> void:
	$AnimatedSprite2D.visible = true
	add_to_group("enemy")
	
func _process(delta: float) -> void:
	killzone.position = $AnimatedSprite2D.position
	
func _physics_process(delta: float) -> void:
	var player = get_tree().get_nodes_in_group("player")[0]
	if not is_on_floor():
		velocity += get_gravity() * delta
		
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
			
	#jumping when running into barriers
	if raycast_front.is_colliding():
		velocity.y = JUMP_VELOCITY
		
	#Dying
	if health < 0:
		_die()
	move_and_slide()
	
#Make the sprite inactive
func _die():
	$AnimatedSprite2D.visible = false  
	set_process(false) 
	set_physics_process(false)  
	set_collision_layer_value(1, false)
	$AnimatedSprite2D/KillZone/CollisionShape2D.set_deferred("disabled", true)  
