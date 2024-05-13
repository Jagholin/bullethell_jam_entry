class_name ExplosiveComponent
extends BaseComponent


const COMPONENT_NAME := &"ExplosiveComponent"

@export var explosion: PackedScene

func get_component_name() -> StringName:
	return COMPONENT_NAME

func explode():
	if explosion!=null:
		var new_explosion := explosion.instantiate()
		new_explosion.global_position = target.global_position
		target.get_parent().add_child(new_explosion)

