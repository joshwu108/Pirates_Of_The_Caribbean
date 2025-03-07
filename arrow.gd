extends CharacterBody2D


@onready var body = $KillZone/CollisionShape2D
var arrow_speed = 20 
var direction = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_tree().get_nodes_in_group("damage_material")[0]
	player.connect("bat_entered", Callable(self, "_on_entered_sword"))
	direction = (player.global_position - global_position).normalized()
	velocity = Vector2(direction.x, 0)
	if direction.x < 0:
		$Sprite2D.flip_h 
		arrow_speed = -20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction.normalized() * arrow_speed * delta


func _on_timer_timeout() -> void:
	queue_free()# Replace with function body.
