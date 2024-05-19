extends StateEnemyDefault
class_name StateEnemyRepositioning

@export var position_provider: PathPositionProviderComponent
## How long will it take to switch to default state.
## if negative, no automatic switch will happen
@export var duration: float = 1.0
## path to set the position provider, if not set, the curve in the position provider will be used instead
@export var path: Path2D

func enter():
	super.enter()
	print("enter StateEnemyRepositioning")
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	damageable.immune = false
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = false
	if path:
		position_provider.path = path.curve
	

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	if elapsed > duration and duration > 0:
		return "StateEnemyDefault"
	if position_provider and position_provider.is_initialised():
		target.position += position_provider.get_next_position_delta(delta)
	else:
		# default behavior if no position provider is set
		target.position += Vector2.UP * 100 * delta
	return ""

