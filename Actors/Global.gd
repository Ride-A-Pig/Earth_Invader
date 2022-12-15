extends Node


signal earthDead
# Called when the node enters the scene tree for the first time.
func _ready():
	Recenter($Player)
	Recenter($Earth)

func Recenter(instance:Node):
	var windowSize = get_viewport().size;
	instance.position = windowSize/2;
