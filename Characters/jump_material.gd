extends Area2D

signal jump(body)

func _ready():
	add_to_group("jump")
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body: Node2D) -> void:
	emit_signal("jump", body)
		
