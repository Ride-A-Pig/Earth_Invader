extends "res://Actors/Enemies/01/Enemy01.gd"


func _ready():
	damage = 20
	hp = 2
	speed = 175
	var targetPosition = Vector2(1080/2,1080/2)
	rotation = (targetPosition-global_position).angle()+PI/2
	linear_velocity = speed * (targetPosition-global_position).normalized()

func Get_Damage(amount):
	hp-=amount
	if(hp<=0):
		#get_node("/root/Scene/Player").Update_Weapon(1)
		var particle:CPUParticles2D = load("res://Actors/Enemies/DestroyParticle.tscn").instance()
		particle.color = Color(1,0,0,1)
		particle.position = global_position
		particle.restart()
		get_node("/root/Scene").add_child(particle)
		queue_free()
