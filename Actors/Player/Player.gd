extends Node2D

export var distance = 150
export var rotateSpeed = 2
export (int, 0, 100) var health = 4
export (int, 0, 1) var firemode = 1
export (float, 0.01, 2)var firespeed = .1
export var offset = .1
export (PackedScene) var bullet

var can_fire = false

func _ready():
	$Area2D.position = Vector2(distance,0);
	$Timer.wait_time = firespeed

func _process(delta):
	rotate(rotateSpeed * delta);
	if(health<=0):
		var _r = get_tree().reload_current_scene()

func Spawn_Bullet():
	if (can_fire):
		var newRotation = (get_global_mouse_position()-$Area2D/Spaceship.global_position).angle()
		match firemode:
			0:
				var b = bullet.instance()
				owner.add_child(b)
				b.global_position = $Area2D.global_position
				b.rotation = newRotation
			1:
				var tempoffset = -offset
				var b = [bullet.instance(),bullet.instance(),bullet.instance()]
				for x in b:
					owner.add_child(x)
					x.global_position = $Area2D.global_position
					x.rotation = (newRotation + tempoffset)
					tempoffset+=offset

func _on_Timer_timeout() -> void:
	Spawn_Bullet()

func _input(_event):
	if(Input.is_action_just_pressed('Fire')):
		if($Timer.is_stopped()):
			Spawn_Bullet()
		$Timer.start()
	elif(Input.is_action_just_released('Fire')):
		$Timer.stop()
		$Timer.wait_time = firespeed
	
func Update_Weapon(value):
	firemode = value
	$WeaponTimer.start()
	
func _on_WeaponTimer_timeout():
	firemode = 0


func _on_Control_startGame():
	can_fire = true


func _on_Earth_death():
	can_fire = false
