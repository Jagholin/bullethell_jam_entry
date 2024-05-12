extends Node2D

@onready var fps_label: Label = %FPSLabel
@onready var count_label: Label = %ProjectileCount


func _process(_delta):
	var currentFps := Performance.get_monitor(Performance.TIME_FPS)
	fps_label.text = "%d" % currentFps
	count_label.text = "%d" % Global.projectile_count
