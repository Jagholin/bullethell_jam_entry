extends Node2D

@onready var main_menu_layer: CanvasLayer = $MainMenuLayer
@onready var pause_menu_layer: CanvasLayer = $PauseMenuLayer

@export var level_scenes: Array[PackedScene]

var current_level: BaseLevel
var current_level_idx: int

func _ready():
	main_menu_layer.show()
	pause_menu_layer.hide()

func _process(_delta):
	pass

## Creates level with idx = current_level_idx and adds it as a child to this node
func start_level():
	var scene := level_scenes[current_level_idx]
	var newLevel := scene.instantiate() as BaseLevel
	current_level = newLevel
	add_child(current_level)

func on_level_exit():
	current_level.queue_free()
	current_level = null
	main_menu_layer.show()

func _on_new_game_button_pressed():
	assert(not current_level)
	main_menu_layer.hide()
	current_level_idx = 0
	start_level()

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	# If we are on web, quitting this way won't work
	if Engine.get_architecture_name().contains("wasm"):
		return
	get_tree().quit()
