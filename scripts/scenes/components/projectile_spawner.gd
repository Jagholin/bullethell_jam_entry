class_name ProjectileSpawnerComponent
extends BaseComponent

const COMPONENT_NAME := &"ProjectileSpawnerComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

@export_group("Projectile spawn settings")
#@export var bullet_pattern: BulletPatternResource
@export var bullet_configs: Array[ProjectileSpawnerConfigResource]
@export_group("")
@export var projectile: PackedScene
## bullet settings used by this spawner
#@export var projectile_settings: BulletSettingsResource
@export var projectiles_parent: Node2D

var active_bullet_configs: Array[ProjectileSpawnerConfigResource]

## Modifiers for the bullet_pattern settings
var interval_modifier_additive: float = 0.0
var interval_modifier_multiplicative: float = 1.0
var projectile_volleys_modifier_additive: int = 0
var projectile_volleys_modifier_multiplicative: float = 1.0
var angle_between_volleys_modifier_additive: float = 0.0
var angle_between_volleys_modifier_multiplicative: float = 1.0
var angle_offset_modifier_additive: float = 0.0
var angle_offset_modifier_multiplicative: float = 1.0

## Secondary spawn points to spawn chained projectiles
class SpawnPoint:
	var position: Vector2
	var direction: Vector2
	var time_elapsed: float = 0.0
	var lifetime: float

class BulletConfigState:
	var elapsed: float = 0.0
	var secondary_spawnpoints: Array[SpawnPoint] = []

var bullet_config_states: Array[BulletConfigState] = []

## Whether the spawner is currently active and emitting projectiles
@export var active: bool = true

#var elapsed: Array[float] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	active_bullet_configs = bullet_configs.duplicate()
	for i in bullet_configs.size():
		bullet_config_states.append(BulletConfigState.new())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for c in active_bullet_configs.size():
		process_config(c, delta)

func override_bullet_config(new_config: ProjectileSpawnerConfigResource) -> ProjectileSpawnerConfigResource:
	# TODO: implement for multiple bullet configs
	assert(active_bullet_configs.size() == 1, "Not implemented for multiple bullet configs yet")
	var old_config := active_bullet_configs[0]
	active_bullet_configs[0] = new_config
	bullet_config_states[0].elapsed = 0.0
	bullet_config_states[0].secondary_spawnpoints.clear()
	return old_config

func process_config(idx: int, delta: float):
	var config := active_bullet_configs[idx]
	var interval := config.bullet_pattern.interval * interval_modifier_multiplicative + interval_modifier_additive
	var configState := bullet_config_states[idx]
	# if the primary emition type is spawnpoints, ignore interval modifiers
	if config.bullet_pattern.emition_type == BulletPatternResource.EmitionType.SPAWNPOINT:
		interval = config.bullet_pattern.interval

	if not active:
		if configState.secondary_spawnpoints.size() > 0:
			configState.secondary_spawnpoints.clear()
		configState.elapsed = 0.0
		return

	configState.elapsed += delta
	while configState.elapsed >= interval:
		fire(config.bullet_pattern, config.bullet_settings, idx, Vector2.ZERO)

		configState.elapsed -= interval

	# process secondary spawn points
	if configState.secondary_spawnpoints.is_empty():
		return

	interval = config.bullet_pattern.chained_bullet_pattern.interval * interval_modifier_multiplicative + interval_modifier_additive
	var clearSpawnArray := false

	for spawnPoint in configState.secondary_spawnpoints:
		spawnPoint.time_elapsed += delta
		while spawnPoint.time_elapsed >= interval and spawnPoint.lifetime > 0:
			fire(config.bullet_pattern.chained_bullet_pattern, config.bullet_settings, idx, spawnPoint.position)
			spawnPoint.time_elapsed -= interval
			spawnPoint.lifetime -= interval
			spawnPoint.position += spawnPoint.direction * interval
		if spawnPoint.lifetime <= 0:
			clearSpawnArray = true

	if clearSpawnArray:
		configState.secondary_spawnpoints = configState.secondary_spawnpoints.filter(func(sp: SpawnPoint) -> bool: return sp.lifetime > 0)

func reset_modifiers():
	interval_modifier_additive = 0.0
	interval_modifier_multiplicative = 1.0
	projectile_volleys_modifier_additive = 0
	projectile_volleys_modifier_multiplicative = 1.0
	angle_between_volleys_modifier_additive = 0.0
	angle_between_volleys_modifier_multiplicative = 1.0
	angle_offset_modifier_additive = 0.0
	angle_offset_modifier_multiplicative = 1.0

func fire(bulletPattern: BulletPatternResource, projectileSettings: BulletSettingsResource, idx: int, spawnPosition: Vector2):
	var angleBetweenVolleys := bulletPattern.angle_between_volleys * angle_between_volleys_modifier_multiplicative + angle_between_volleys_modifier_additive
	var angleOffset := bulletPattern.angle_offset * angle_offset_modifier_multiplicative + angle_offset_modifier_additive
	var projectileVolleys := floori(bulletPattern.projectile_volleys * projectile_volleys_modifier_multiplicative) + projectile_volleys_modifier_additive
	#var angle := -0.5 * bulletPattern.angle_between_volleys * (bulletPattern.projectile_volleys - 1) + bulletPattern.angle_offset
	var angle := -0.5 * angleBetweenVolleys * (projectileVolleys - 1) + angleOffset
	#var offset := -0.5 * bulletPattern.projectile_volley_offset * (bulletPattern.projectile_volleys - 1)
	var offset := -0.5 * bulletPattern.projectile_volley_offset * (projectileVolleys - 1)
	for i in projectileVolleys:
		# calculate the angle for the projectile, and initial position
		if bulletPattern.emition_type == BulletPatternResource.EmitionType.PROJECTILE:
			var new_projectile := projectile.instantiate() as Projectile
			new_projectile.direction = bulletPattern.initial_direction.rotated(deg_to_rad(angle))
			new_projectile.velocity = bulletPattern.initial_velocity
			new_projectile.global_position = global_position + spawnPosition + offset
			new_projectile.collision_mask = projectileSettings.get_collision_mask()
			new_projectile.collision_layer = 0
			new_projectile.bullet_sprite = projectileSettings.sprite_frames
			projectiles_parent.add_child(new_projectile)
			#get_tree().get_current_scene().projectile_count += 1
			Global.projectile_count += 1
		elif bulletPattern.emition_type == BulletPatternResource.EmitionType.SPAWNPOINT:
			var newSpawnPoint := SpawnPoint.new()
			newSpawnPoint.position = spawnPosition + offset
			newSpawnPoint.direction = bulletPattern.initial_direction.rotated(deg_to_rad(angle))
			newSpawnPoint.lifetime = bulletPattern.spawnpoint_lifetime
			bullet_config_states[idx].secondary_spawnpoints.append(newSpawnPoint)
		else:
			assert(false, "Unknown emition type")

		angle += angleBetweenVolleys
		offset += bulletPattern.projectile_volley_offset
