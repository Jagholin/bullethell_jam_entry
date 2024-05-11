extends Node2D
class_name Damageable
@export var health = 10
@export var max_health = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.max_value = max_health
	$ProgressBar.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func destroy():
	get_parent().queue_free()

func damage():
	health -= 1
	$ProgressBar.value = health
	if health <= 0:
		destroy()
	

