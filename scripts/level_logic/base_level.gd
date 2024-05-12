## Base class for all levels in the game, contains shared functionality like level movement and progression, as well as some common enemy spawning logic.
class_name BaseLevel
extends Node2D

@export var camera: Camera2D
@export var player: Player
## how many pixels the level should move per second
@export var level_scroll_speed: float = 40

func _ready():
	if camera:
		camera.position = get_viewport_rect().size / 2
	if player:
		player.position = camera.position + Vector2(0, 100)
		player.level_velocity = Vector2(0, -level_scroll_speed)
	#background.position = camera.position

func _physics_process(delta):
	if camera:
		camera.position.y -= level_scroll_speed * delta

func _process(_delta):
	pass
