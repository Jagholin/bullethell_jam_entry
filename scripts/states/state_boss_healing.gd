extends StateBossBase
class_name StateBossHealing


var last_health_sample: int = -1
var recovery_rate: int = 1


func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		return "StateBossRandomize"
	
	var current_health_sample = target.get_component("DamageableComponent").health
	if last_health_sample != -1:
		if current_health_sample < last_health_sample:
			target.get_component("DamageableComponent").health = clamp(current_health_sample+recovery_rate, 0, target.get_component("DamageableComponent").max_health)
	last_health_sample = current_health_sample

	return ""


func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = false


func exit() -> void:
	super.exit()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
