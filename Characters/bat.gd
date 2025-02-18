extends CharacterBody2D

@export var patrol_range: int # Distance to patrol in each direction
@export var speed = 300.0 # Speed of movement
@export var detection_range = 500.0  # Distance at which enemy detects the player
@export var health = 100
# Enemy properties
var is_patrolling = true
var is_chasing = false
var patrol_direction = 1  # 1 = right, -1 = left

# Areas for detection (set up in the editor)
@onready var detection_area = $DetectionArea
@onready var sprite = $AnimatedSprite2D

# Variables to store patrol boundaries
var patrol_start_position = Vector2.ZERO
var patrol_end_position = Vector2.ZERO

func _ready():
	add_to_group("bats")
	# Set patrol start and end points based on position
	patrol_start_position = position
	patrol_end_position = patrol_start_position + Vector2(patrol_range, 0)


func _process(delta):
	if is_patrolling:
		patrol()
	if is_chasing:
		chase_player()
	if health <= 0:
		_die()

func patrol():
	# Move the enemy back and forth within the patrol range
	if patrol_direction == 1 and position.y >= patrol_end_position.y:
		patrol_direction = -1  # Change direction to left
	elif patrol_direction == -1 and position.y <= patrol_start_position.y:
		patrol_direction = 1  # Change direction to right
		
	velocity.y = speed * patrol_direction
	move_and_slide()
	sprite.flip_h = patrol_direction == -1  # Flip when moving left

	# Check if the enemy is close enough to the player to start chasing
	if is_within_detection_range():
		is_patrolling = false
		is_chasing = true

func chase_player():
	var player = get_tree().get_nodes_in_group("player")[0]
	# Move towards the player
	var direction_to_player = (player.global_position - position).normalized()
	velocity = direction_to_player * speed
	move_and_slide()
	sprite.flip_h = direction_to_player.y < 0  # Flip when moving left

	# If the player is out of range, stop chasing and start patrolling
	if !is_within_detection_range():
		is_chasing = false
		is_patrolling = true

func is_within_detection_range() -> bool:
	var player = get_tree().get_nodes_in_group("player")[0]
	# Check if the player is within detection range of the enemy
	return position.distance_to(player.global_position) <= detection_range
	
func _die():
	$AnimatedSprite2D.visible = false  
	set_process(false) 
	set_physics_process(false)  
	set_collision_layer_value(1, false)
	$KillZone/CollisionShape2D.set_deferred("disabled", true)
