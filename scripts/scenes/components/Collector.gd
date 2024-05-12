class_name CollectorComponent
extends BaseComponent


const COMPONENT_NAME := &"CollectorComponent"


func get_component_name() -> StringName:
	return COMPONENT_NAME

func collect(item: Resource):
	print(item)
	#target.collect()
