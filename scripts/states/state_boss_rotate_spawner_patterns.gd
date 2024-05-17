extends StateBossBase
class_name StateBossRotateSpawnerPattern

func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	if not spawner.active:
		spawner.active = true
	else:
		spawner.active_bullet_configs[0].bullet_pattern.projectile_volleys +=1
		spawner.active_bullet_configs[0].bullet_pattern.projectile_volleys = clamp(spawner.active_bullet_configs[0].bullet_pattern.projectile_volleys, 1, 6)
		spawner.active_bullet_configs[0].bullet_pattern.angle_between_volleys = 360.0 / spawner.active_bullet_configs[0].bullet_pattern.projectile_volleys



func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		# this just transitions to itself which adds an extra volley every 3s
		return "StateBossRotateSpawnerPattern"
	else:
		return ""
