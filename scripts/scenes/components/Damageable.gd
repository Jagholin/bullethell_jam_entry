class_name DamageableComponent
extends BaseComponent

const COMPONENT_NAME := &"DamageableComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

@export var health = 10
@export var max_health = 10

@onready var progress_bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar.max_value = max_health
	progress_bar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func destroy():
	target.queue_free()

## Type of damage the bullet caused. Can be used to determine what happens to the bullet after the hit.
enum DamageResult { HIT, NOTHIT }
func damage() -> DamageResult:
	health -= 1
	progress_bar.value = health
	if health <= 0:
		destroy()
	return DamageResult.HIT

