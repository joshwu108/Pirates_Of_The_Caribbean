extends CharacterBody2D

const SPEED = 200.0
const attack_range = 50
const detect_range = 500
const JUMP_VELOCITY = -450
@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var raycast = $RayCast2D
@onready var raycast_front = $RayCast2D2

func _ready() -> void:
	add_to_group("enemy")
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var distance = self.global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	if distance < detect_range:
		velocity.x = SPEED * direction.x
	else:
		velocity = Vector2.ZERO
	#if direction.y < -0.1 && is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	#Detect Gaps and Jump
	if not raycast.is_colliding():
		if direction.y < -0.1 and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
	if raycast_front.is_colliding():
		if direction.y < -0.1 and is_on_floor():
			velocity.y = JUMP_VELOCITY
	move_and_slide()
