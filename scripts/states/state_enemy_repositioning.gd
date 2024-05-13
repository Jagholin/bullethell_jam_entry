extends StateEnemyDefault
class_name StateEnemyRepositioning


func enter():
	super.enter()
	print("enter StateEnemyRepositioning")
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	damageable.immune = false
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = false
	

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	if elapsed>1.0:
		return "StateEnemyDefault"
	target.position += Vector2.UP * 100 * delta
	return ""

