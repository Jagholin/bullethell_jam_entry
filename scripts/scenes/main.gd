extends Node2D

@onready var main_menu_layer: CanvasLayer = $MainMenuLayer
@onready var pause_menu_layer: CanvasLayer = $PauseMenuLayer
@onready var credits_layer: CanvasLayer = $CreditsLayer
@onready var hud_layer: CanvasLayer = $HUDLayer
@onready var end_layer: CanvasLayer = $EndMenu

@onready var deaths_label: Label = %DeathsCounterLabel

@export var level_scenes: Array[PackedScene]

var current_level: BaseLevel
var current_level_idx: int

func _ready():
	main_menu_layer.show()
	pause_menu_layer.hide()
	end_layer.hide()
	credits_layer.hide()
	hud_layer.hide()
	Global.death_counter_changed.connect(on_deathcounter_updated)

func _process(_delta):
	if Global.end_screen:
		_on_boss_destroyed()
		

func _unhandled_input(event):
	if event.is_action_pressed("pause_menu"):
		pause_menu_layer.show()
		get_tree().paused = true

## Creates level with idx = current_level_idx and adds it as a child to this node
func start_level():
	var scene := level_scenes[current_level_idx]
	var newLevel := scene.instantiate() as BaseLevel
	current_level = newLevel
	add_child(current_level)
	hud_layer.show()

func on_level_exit():
	current_level.queue_free()
	current_level = null
	main_menu_layer.show()
	hud_layer.hide()

func _on_new_game_button_pressed():
	assert(not current_level)
	main_menu_layer.hide()
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.play()
	current_level_idx = 0
	start_level()

func _on_credits_button_pressed():
	# TODO: implement this
	main_menu_layer.hide()
	credits_layer.show()

# This is for the button in the main menu
func _on_exit_button_pressed():
	# If we are on web, quitting this way won't work
	if Engine.get_architecture_name().contains("wasm"):
		return
	get_tree().quit()

func finish_pause():
	get_tree().paused = false
	pause_menu_layer.hide()

func _on_resume_button_pressed():
	finish_pause()

func _on_boss_destroyed():
	get_tree().paused = true
	end_layer.show()

func _on_retry_button_pressed():
	get_tree().reload_current_scene()


func _on_exit_to_menu_button_pressed():
	finish_pause()
	on_level_exit()

# This is for the button in the pause menu
func _on_quit_button_pressed():
	finish_pause()
	_on_exit_button_pressed()

func _on_credits_back_button_pressed():
	credits_layer.hide()
	main_menu_layer.show()

func on_deathcounter_updated():
	deaths_label.text = "Deaths: %d" % Global.death_counter
