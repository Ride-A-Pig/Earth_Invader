extends Resource

const path = "user://save_01.res"
export var high_score = 0



func _init():
	if not ResourceLoader.exists(path):
		ResourceSaver.save(path,self)
