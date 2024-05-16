extends StateBossBase
class_name StateBossMirror

var mirror_spawner_setting: BulletPatternResource = preload("res://resources/bullet_patterns/miniboss_pattern_mirror.tres")
var previous_spawner_setting: BulletPatternResource

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		return "StateBossRandomize"
		
	var player := get_tree().current_scene.get_node("Player") as Player
	if player.global_position < target.global_position:
		target.position += Vector2.LEFT * 70 * delta
	else:
		target.position += Vector2.RIGHT * 70 * delta
	return ""



func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	previous_spawner_setting = spawner.bullet_pattern
	spawner.bullet_pattern = mirror_spawner_setting
	#spawner.interval = 0.1
	#spawner.projectile_volleys = 1


func exit() -> void:
	super.exit()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	spawner.bullet_pattern = previous_spawner_setting
	#spawner.interval = 0.4
	#spawner.projectile_volleys = 12
