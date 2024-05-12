class_name GrazeComponent
extends BaseComponent
# I tried making it extend DamageableComponent but the get_component doesn't take into account inheritance, that seems an overkill, this is a little duplicative but works
# All the logic to handle this is now in the projectile
const COMPONENT_NAME := &"GrazeComponent"


func get_component_name() -> StringName:
	return COMPONENT_NAME
