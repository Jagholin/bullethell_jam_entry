class_name TimedExploderComponent
extends BaseComponent


const COMPONENT_NAME := &"TimedExploderComponent"

@export var timeout: float

var elapsed: float = 0

func get_component_name() -> StringName:
	return COMPONENT_NAME

func _process(delta):
	elapsed += delta
	if elapsed > timeout:
		target.destroy()
