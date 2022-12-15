extends Control

onready var new_save = ResourceLoader.load(load("res://Actors/Save.gd").new().path)


signal startGame

var player
var score = 0
var Earth
var start_time = 20

func _ready():
	$HighScore.text = "High Score:" + str(new_save.high_score)
	Earth = get_node("/root/Scene/Earth")
	$TextureRect/EarthHealthBar.max_value = Earth.hp
	$TextureRect/EarthHealthBar.value = Earth.hp
	$TimerLable.text = String(start_time)
	$TextureRect.hide()
	$ScoreLable.hide()
	$YourScore.hide()
	$TimerLable.hide()
	
	
func Update_Score(arg):
	score+=arg
	$ScoreLable/Score.text = String(score)
	
	
func _on_Earth_healthChanged(currenthp):
	$TextureRect/EarthHealthBar.value = currenthp


func _on_Button_pressed():
	$AudioStreamPlayer.play()
	$Start.hide()
	$HighScore.hide()
	$Title.hide()
	$TextureRect.show()
	$ScoreLable.show()
	$TimerLable.show()
	$TimerLable/Timer.start()
	emit_signal("startGame")



func _on_Earth_death():
	$TimerLable/Timer.stop()
	if score > new_save.high_score:
		new_save.high_score = score
		ResourceSaver.save(new_save.path, new_save)
		print("New Socre!")
	$HighScore.text = "High Score:" + str(new_save.high_score)
	$MainMenu.show()
	$Title.text = "Lose!"
	$Title.show()
	$YourScore.show()
	$YourScore.text = "Your Score:" + str(score)
	$HighScore.show()


func _on_MainMenu_pressed():
	get_tree().reload_current_scene()

func _on_Timer_timeout():
	start_time-=1
	if start_time<=0:
		_on_Timer_finished()
	$TimerLable.text = String(start_time)


func _on_Timer_finished():
	$TimerLable/Timer.stop()
	$"../EnemyLayer".queue_free()
	if score > new_save.high_score:
		new_save.high_score = score
		ResourceSaver.save(new_save.path, new_save)
		print("New Socre!")
	$HighScore.text = "High Score:" + str(new_save.high_score)
	$MainMenu.show()
	$Title.text = "Win!"
	$Title.show()
	$YourScore.show()
	$YourScore.text = "Your Score:" + str(score)
	$HighScore.show()

