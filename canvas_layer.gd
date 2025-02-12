extends CanvasLayer

@onready var player 
@onready var health_bar = $Panel/ProgressBar

func _ready() -> void:
	add_to_group("health")
	player = get_tree().get_nodes_in_group("player")[0]
	health_bar.max_value = 1000
	health_bar.value = player.Health
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update_health(amount: int) -> void:
	player.Health-=amount
	health_bar.value=player.Health
