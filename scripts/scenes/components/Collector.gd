class_name CollectorComponent
extends BaseComponent


const COMPONENT_NAME := &"CollectorComponent"


func get_component_name() -> StringName:
	return COMPONENT_NAME

func collect(item: String):
	print(item)
	# TODO modify the ProjectileSpawner component accordingly
	#target.collect()
