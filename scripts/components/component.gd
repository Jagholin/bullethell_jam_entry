class_name BaseComponent
extends Node2D

var target: Node2D

func _notification(what):
	if what == Node.NOTIFICATION_PARENTED:
		target = get_parent()
		if target.has_method(&"register_component"):
			target.register_component(self)
	elif what == Node.NOTIFICATION_UNPARENTED:
		if target.has_method(&"unregister_component"):
			target.unregister_component(self)
		target = null

func get_component_name() -> StringName:
	assert(false, "get_component_name() must be overridden in derived classes.")
	return &"BaseComponent"
