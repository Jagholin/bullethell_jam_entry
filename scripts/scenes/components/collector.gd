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
		spawner.active_bullet_configs[0].bullet_pattern.initial_velocity *= 1.5
	elif item.item_type == ItemSettingsResource.ItemType.MORE_VOLLEYS:
		spawner.active_bullet_configs[0].bullet_pattern.projectile_volleys += 2		
	elif item.item_type == ItemSettingsResource.ItemType.MORE_BULLETS:
		spawner.active_bullet_configs[0].bullet_pattern.interval *= 0.66
	elif item.item_type == ItemSettingsResource.ItemType.BIGGER_BULLETS:
		spawner.active_bullet_configs[0].bullet_pattern.scale *= 1.5
		
