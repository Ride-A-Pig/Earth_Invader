extends Node2D

export (Array, PackedScene) var moblist

export var ratio = 1

func _ready():
	randomize()

func _on_Timer_timeout():
	var mobSpawnPosition = $Path2D/PathFollow2D
	mobSpawnPosition.unit_offset = randf()
	var mob
	if(randf()>ratio):
		mob = moblist[1].instance()
	else:
		mob = moblist[0].instance()
	mob.global_position = mobSpawnPosition.global_position
	if $"../EnemyLayer"!=null:
		$"../EnemyLayer".add_child(mob)


func _on_Timer2_timeout():
	if($Timer.wait_time>0.1):
		$Timer.wait_time-=0.01
		ratio -=0.0015
	else:
		$Timer2.stop()


func _on_Control_startGame():
	$Timer.start()
	$Timer2.start()


func _on_Earth_death():
	$Timer.stop()
	$Timer2.stop()
