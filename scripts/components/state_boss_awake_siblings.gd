extends State
class_name StateEnemyAwakeSiblings


@export var siblings: Array[Enemy]

func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	if not spawner.active:
		spawner.active = true
		
	for sibling in siblings:
		var sibling_spawner := sibling.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
		if not sibling_spawner.active:
			sibling_spawner.active = true

		
