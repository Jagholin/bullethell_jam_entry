extends State
class_name StateEnemyAngry

var angry_spawner_settings: BulletPatternResource = preload("res://resources/bullet_patterns/enemy_pattern_angry.tres")

func get_animation_name() -> String:
	return "angry"


func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	spawner.bullet_pattern = angry_spawner_settings
	#spawner.interval = 0.2
	#spawner.projectile_volleys = 30

