extends Area2D

export var speed = 800

func _physics_process(delta):
	position += transform.x*speed*delta

func _on_Area2D_body_entered(body:Node):
	if(body.name == "Earth"):
		body.Get_Damage(1)
		queue_free()
	elif (body.is_in_group("enemy")):
		body.Get_Damage(1)
		queue_free()


func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport) -> void:
	queue_free()
