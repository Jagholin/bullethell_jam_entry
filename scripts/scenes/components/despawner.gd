class_name DespawnerComponent
extends BaseComponent

const COMPONENT_NAME := &"DespawnerComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME


@export var buffer = 20

func _process(_delta):
	var trns := get_global_transform_with_canvas()
	var viewportPosition = trns * position
	var viewportRect := get_viewport_rect().grow(buffer)
	if not viewportRect.has_point(viewportPosition):
		target.destroy()
