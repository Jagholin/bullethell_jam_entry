extends StateBossBase
class_name StateBossRotateSpawnerPattern

var accumulated_volley_count := 0

func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	if not spawner.active:
		spawner.active = true
	# else:
	spawner.set_config_active_state(0, true)
	accumulated_volley_count += 1
	accumulated_volley_count = clamp(accumulated_volley_count, 1, 6)
	#spawner.reset_modifiers()
	#spawner.modify_volley_count(accumulated_volley_count, true)
	spawner.active_bullet_configs[0].bullet_pattern.projectile_volleys = accumulated_volley_count
	spawner.active_bullet_configs[0].bullet_pattern.angle_between_volleys = 360.0 / accumulated_volley_count

func exit() -> void:
	super.exit()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	# spawner.active = false
	spawner.set_config_active_state(0, false)

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		# this just transitions to itself which adds an extra volley every 3s
		return "StateBossRotateSpawnerPattern"
	else:
		return ""
