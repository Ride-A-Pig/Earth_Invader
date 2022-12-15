extends RigidBody2D


var minSpeed = 125
var maxSpeed = 125
var speed
var hp = 2
var damage = 10
var isInsideViewport = false



func _ready():
	speed = rand_range(minSpeed,maxSpeed)
	var targetPosition = Vector2(1080/2,1080/2)
	rotation = (targetPosition-global_position).angle()+PI/2
	linear_velocity = speed * (targetPosition-global_position).normalized()

func Get_Damage(amount):
	hp-=amount
	if(hp<=0):
		get_node("/root/Scene/Control").Update_Score(1)
		var particle:CPUParticles2D = load("res://Actors/Enemies/DestroyParticle.tscn").instance()
		particle.position = global_position
		particle.restart()
		get_node("/root/Scene").add_child(particle)
		queue_free()

func _on_VisibilityNotifier2D_viewport_entered(_viewport: Viewport) -> void:
	isInsideViewport = true
	
func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport) -> void:
	if(isInsideViewport):
		queue_free()

func _on_RigidBody2D_body_entered(body: Node) -> void:
	if(body.name == "Earth"):
		body.Get_Damage(damage)
		queue_free()
		
		
		
		
		
		
		
		
