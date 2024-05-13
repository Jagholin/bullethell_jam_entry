extends Node
class_name State

var animation_name: String = ""

var target: Node2D
var state_expire_timeout: float = -1
var state_expiration_ticks: int = -1
var elapsed: float = 0
var active: bool = false

func enter() -> void:
	print("enter into base state")
	var sprite := target.get_node("AnimatedSprite2D") as AnimatedSprite2D
	if sprite != null:
		sprite.animation = get_animation_name()
	elapsed = 0.0
	active = true

func exit() -> void:
	pass

func process_frame(delta: float) -> String:
	if active:
		elapsed += delta
	return ""

func get_animation_name() -> String:
	return "default"
