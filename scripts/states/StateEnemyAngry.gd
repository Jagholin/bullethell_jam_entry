extends State
class_name StateEnemyAngry

func get_animation_name() -> String:
	return "angry"


func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	spawner.interval = 0.2
	spawner.projectile_volleys = 30

