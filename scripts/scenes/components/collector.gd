class_name CollectorComponent
extends BaseComponent


const COMPONENT_NAME := &"CollectorComponent"
@onready var inventory: Array[ItemSettingsResource] = []

func get_component_name() -> StringName:
	return COMPONENT_NAME

func collect(item: ItemSettingsResource):
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	inventory.append(item)
	if item.item_type == ItemSettingsResource.ItemType.FASTER_BULLETS:
		# spawner.interval *= 0.66
		spawner.interval_modifier_multiplicative *= 0.66
	elif item.item_type == ItemSettingsResource.ItemType.MORE_VOLLEYS:
		# spawner.projectile_volleys += 2
		spawner.projectile_volleys_modifier_additive += 2
		
