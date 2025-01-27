extends TextEdit

@onready var timer = $Timer

func _on_Area2D_body_entered(body):
	if(body.name == 'Camera2D'):
		self.visible=true
		timer.start()
		
func _on_Timer_timeout():
	self.visible = false 
