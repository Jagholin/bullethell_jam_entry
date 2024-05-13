extends State
class_name StateEnemyDefault

func get_animation_name() -> String:
	return "default"


func enter():
	super.enter()
	print("enter default enemy")
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	damageable.immune = false
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true


func process_frame(delta: float) -> String:
	super.process_frame(delta)
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	if 1.0 * damageable.health / damageable.max_health <0.5:
		return "StateEnemyAngry"
	if elapsed>1.0:
		return "StateEnemyRepositioning"
	return ""
