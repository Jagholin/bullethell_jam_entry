extends StateBossBase
class_name StateBossMirror

var mirror_spawner_setting: ProjectileSpawnerConfigResource = preload("res://resources/bullet_configs/miniboss_mirror.tres")
var previous_spawner_setting: ProjectileSpawnerConfigResource

var player: Player

func _ready():
	super._ready()
	PlayerProvider.on_player_initialized(func(p: Player): player = p)

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	if elapsed>3:
		return "StateBossRandomize"
		
	# var player := get_tree().current_scene.get_node("Player") as Player
	assert(player, "if this assert fails, you can just add if not player: return line or something")
	if player.global_position < target.global_position:
		target.position += Vector2.LEFT * 70 * delta
	else:
		target.position += Vector2.RIGHT * 70 * delta
	return ""



func enter() -> void:
	super.enter()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	previous_spawner_setting = spawner.override_bullet_config(mirror_spawner_setting)
	#spawner.interval = 0.1
	#spawner.projectile_volleys = 1


func exit() -> void:
	super.exit()
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	spawner.override_bullet_config(previous_spawner_setting)
	#spawner.interval = 0.4
	#spawner.projectile_volleys = 12
