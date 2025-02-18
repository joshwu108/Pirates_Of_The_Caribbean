extends CharacterBody2D

@export var player: CharacterBody2D
@export var patrol_range: int # Distance to patrol in each direction
@export var speed = 100.0 # Speed of movement
@export var detection_range = 200.0  # Distance at which enemy detects the player
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
	# Set patrol start and end points based on position
	patrol_start_position = position
	patrol_end_position = patrol_start_position + Vector2(patrol_range, 0)


func _process(delta):
	if is_patrolling:
		patrol()
	if is_chasing:
		chase_player()

func patrol():
	# Move the enemy back and forth within the patrol range
	if patrol_direction == 1 and position.x >= patrol_end_position.x:
		patrol_direction = -1  # Change direction to left
	elif patrol_direction == -1 and position.x <= patrol_start_position.x:
		patrol_direction = 1  # Change direction to right
		
	velocity.x = speed * patrol_direction
	move_and_slide()
	sprite.flip_h = patrol_direction == -1  # Flip when moving left

	# Check if the enemy is close enough to the player to start chasing
	if player and is_within_detection_range():
		is_patrolling = false
		is_chasing = true

func chase_player():
	# Move towards the player
	var direction_to_player = (player.position - position).normalized()
	velocity = direction_to_player * speed
	move_and_slide()
	sprite.flip_h = direction_to_player.x < 0  # Flip when moving left

	# If the player is out of range, stop chasing and start patrolling
	if !is_within_detection_range():
		is_chasing = false
		is_patrolling = true

func is_within_detection_range() -> bool:
	# Check if the player is within detection range of the enemy
	return position.distance_to(player.position) <= detection_range
