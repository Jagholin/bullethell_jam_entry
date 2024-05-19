extends StateEnemyDefault
class_name StateEnemyRepositioning

@export var position_provider: PathPositionProviderComponent
@export var duration: float = 1.0

func enter():
	super.enter()
	print("enter StateEnemyRepositioning")
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	damageable.immune = false
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = false
	

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	if elapsed > duration:
		return "StateEnemyDefault"
	if position_provider and position_provider.is_initialised():
		target.position += position_provider.get_next_position_delta(delta)
	else:
		# default behavior if no position provider is set
		target.position += Vector2.UP * 100 * delta
	return ""

