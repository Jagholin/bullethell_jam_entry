class_name DespawnerComponent
extends BaseComponent

const COMPONENT_NAME := &"DespawnerComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME


@export var buffer = 20

func _process(_delta):
	if global_position.x < -buffer or global_position.y < -buffer \
		or global_position.x > get_viewport_rect().end.x + buffer \
		or global_position.y > get_viewport_rect().end.y + buffer:
		target.destroy()
