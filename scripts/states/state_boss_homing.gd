extends StateBossBase
class_name StateBossHoming

@export var homing_projectile: PackedScene
@export var regular_projectile: PackedScene

var homing_spawner_setting: BulletPatternResource = preload("res://resources/bullet_patterns/miniboss_pattern_homing.tres")
var previous_setting: BulletPatternResource

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		return "StateBossRandomize"
		
	return ""


func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	previous_setting = spawner.bullet_pattern
	spawner.bullet_pattern = homing_spawner_setting
	spawner.active = true
	#spawner.interval = 1.5
	#spawner.projectile_volleys = 1
	spawner.projectile = homing_projectile


func exit() -> void:
	super.exit()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.bullet_pattern = previous_setting
	spawner.active = true
	#spawner.interval = 0.4
	#spawner.projectile_volleys = 12
	spawner.projectile = regular_projectile
