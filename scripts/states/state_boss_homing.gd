extends StateBossBase
class_name StateBossHoming

@export var homing_projectile: PackedScene
@export var regular_projectile: PackedScene

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		return "StateBossRandomize"
		
	return ""


func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	spawner.interval = 1.5
	spawner.projectile_volleys = 1
	spawner.projectile = homing_projectile


func exit() -> void:
	super.exit()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	spawner.interval = 0.4
	spawner.projectile_volleys = 12
	spawner.projectile = regular_projectile
