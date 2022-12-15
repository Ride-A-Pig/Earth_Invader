extends KinematicBody2D

signal healthChanged(currenthp)
signal death()


export var hp = 100.0

func Get_Damage(amount):
	hp -= amount
	emit_signal("healthChanged",hp)
	if(hp<=0):
		emit_signal("death")
		$Particles2D.emitting = true
		$CollisionShape2D.queue_free()
		$Control.queue_free()
