extends Node

class_name damageable
# Called when the node enters the scene tree for the first time.


@export var health : float = 3 :
	get:
		return health

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_tree_animation_finished(anim_name):
	
	pass # Replace with function body.
