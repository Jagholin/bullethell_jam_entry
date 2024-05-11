extends Node2D

@onready var fps_label: Label = %FPSLabel

func _process(_delta):
	var currentFps := Performance.get_monitor(Performance.TIME_FPS)
	fps_label.text = "%d" % currentFps
