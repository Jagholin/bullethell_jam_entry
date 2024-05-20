## Base class for all levels in the game, contains shared functionality like level movement and progression, as well as some common enemy spawning logic.
class_name BaseLevel
extends Node2D

@export var camera: Camera2D
@export var player: Player
@export var projectile_parent: Node2D
## how many pixels the level should move per second
@export var level_scroll_speed: float = 70

const LevelPhases = [ &"BeforeMidboss", &"Midboss", &"SecondBoss", &"Boss" ]
var current_phase: StringName = &"BeforeMidboss":
	set(value):
		if current_phase == value:
			return
		assert(value in LevelPhases)
		current_phase = value
		#print("Level phase changed to", value)
		level_phase_changed.emit()

signal level_phase_changed

func _exit_tree():
	LevelProvider.set_level(null)

func _ready():
	if camera:
		camera.position = get_viewport_rect().size / 2
	if player:
		player.position = camera.position + Vector2(0, 100)
		player.level_velocity = Vector2(0, -level_scroll_speed)
	#background.position = camera.position
	if projectile_parent:
		for child in get_children():
			if child is Enemy:
				child.projectile_parent = projectile_parent
	LevelProvider.set_level(self)

func _physics_process(delta):
	if camera:
		camera.position.y -= level_scroll_speed * delta

func _process(_delta):
	var currentFps := Performance.get_monitor(Performance.TIME_FPS)
	DisplayServer.window_set_title("fps: " + str(currentFps))

func stop_scroll():
	level_scroll_speed = 0
	player.level_velocity = Vector2.ZERO

func resume_scroll():
	level_scroll_speed = 70
	player.level_velocity = Vector2(0, -level_scroll_speed)
