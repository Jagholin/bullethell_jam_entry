class_name ProjectileSpawnerComponent
extends BaseComponent

const COMPONENT_NAME := &"ProjectileSpawnerComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

@export_group("Projectile spawn settings")
@export var bullet_pattern: BulletPatternResource
@export_group("")
@export var projectile: PackedScene
## bullet settings used by this spawner
@export var projectile_settings: BulletSettingsResource
@export var projectiles_parent: Node2D

## Modifiers for the bullet_pattern settings
var interval_modifier_additive: float = 0.0
var interval_modifier_multiplicative: float = 1.0
var projectile_volleys_modifier_additive: int = 0
var projectile_volleys_modifier_multiplicative: float = 1.0
var angle_between_volleys_modifier_additive: float = 0.0
var angle_between_volleys_modifier_multiplicative: float = 1.0
var angle_offset_modifier_additive: float = 0.0
var angle_offset_modifier_multiplicative: float = 1.0

## Whether the spawner is currently active and emitting projectiles
@export var active: bool = true

var elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var interval := bullet_pattern.interval * interval_modifier_multiplicative + interval_modifier_additive
	if not active:
		elapsed = 0
		return
	elapsed += delta
	while elapsed >= interval:
		fire()
		elapsed -= interval

func reset_modifiers():
	interval_modifier_additive = 0.0
	interval_modifier_multiplicative = 1.0
	projectile_volleys_modifier_additive = 0
	projectile_volleys_modifier_multiplicative = 1.0
	angle_between_volleys_modifier_additive = 0.0
	angle_between_volleys_modifier_multiplicative = 1.0
	angle_offset_modifier_additive = 0.0
	angle_offset_modifier_multiplicative = 1.0

func fire():
	var angleBetweenVolleys := bullet_pattern.angle_between_volleys * angle_between_volleys_modifier_multiplicative + angle_between_volleys_modifier_additive
	var angleOffset := bullet_pattern.angle_offset * angle_offset_modifier_multiplicative + angle_offset_modifier_additive
	var projectileVolleys := floori(bullet_pattern.projectile_volleys * projectile_volleys_modifier_multiplicative) + projectile_volleys_modifier_additive
	#var angle := -0.5 * bullet_pattern.angle_between_volleys * (bullet_pattern.projectile_volleys - 1) + bullet_pattern.angle_offset
	var angle := -0.5 * angleBetweenVolleys * (projectileVolleys - 1) + angleOffset
	#var offset := -0.5 * bullet_pattern.projectile_volley_offset * (bullet_pattern.projectile_volleys - 1)
	var offset := -0.5 * bullet_pattern.projectile_volley_offset * (projectileVolleys - 1)
	for i in projectileVolleys:
		# calculate the angle for the projectile, and initial position
		var new_projectile := projectile.instantiate() as Projectile
		new_projectile.direction = bullet_pattern.initial_direction.rotated(deg_to_rad(angle))
		new_projectile.velocity = bullet_pattern.initial_velocity
		new_projectile.global_position = global_position + offset
		new_projectile.collision_mask = projectile_settings.get_collision_mask()
		new_projectile.collision_layer = 0
		new_projectile.bullet_sprite = projectile_settings.sprite_frames
		projectiles_parent.add_child(new_projectile)
		#get_tree().get_current_scene().projectile_count += 1
		Global.projectile_count += 1

		angle += angleBetweenVolleys
		offset += bullet_pattern.projectile_volley_offset
