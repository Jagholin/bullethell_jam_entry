extends State
class_name StateEnemyDefault

func get_animation_name() -> String:
	return "default"


func process_frame(delta: float) -> String:
	super.process_frame(delta)
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	if 1.0 * damageable.health / damageable.max_health <0.2:
		return "StateEnemyAngry"
	if elapsed>1.0:
		return "StateEnemyRepositioning"
	return ""
