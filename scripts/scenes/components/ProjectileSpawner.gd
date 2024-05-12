class_name ProjectileSpawnerComponent
extends BaseComponent

const COMPONENT_NAME := &"ProjectileSpawnerComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

@export_group("Projectile spawn settings")
## Interval between each volley of projectiles, in seconds
@export var interval: float = 0.5
## Number of volleys of projectiles to spawn
@export var projectile_volleys: int = 1
## Angle between projectiles in a volley, in degrees
@export var angle_between_volleys: float = 0.0
## Offset angle for the center of the volley, in degrees
@export var angle_offset: float = 0.0
## Offset between projectiles in a volley
@export var projectile_volley_offset: Vector2 = Vector2(2.0, 0)
@export_group("")
@export var projectile: PackedScene
## bullet settings used by this spawner
@export var projectile_settings: BulletSettingsResource
@export var projectiles_parent: Node2D

## Whether the spawner is currently active and emitting projectiles
@export var active: bool = true

var elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active:
		elapsed = 0
		return
	elapsed += delta
	while elapsed >= interval:
		fire()
		elapsed -= interval


func fire():
	var angle := -0.5 * angle_between_volleys * (projectile_volleys - 1) + angle_offset
	var offset := -0.5 * projectile_volley_offset * (projectile_volleys - 1)
	for i in projectile_volleys:
		# calculate the angle for the projectile, and initial position
		var new_projectile := projectile.instantiate() as Projectile
		new_projectile.direction = projectile_settings.initial_direction.rotated(deg_to_rad(angle))
		new_projectile.velocity = projectile_settings.initial_velocity
		new_projectile.global_position = global_position + offset
		new_projectile.collision_mask = projectile_settings.get_collision_mask()
		new_projectile.collision_layer = 0
		new_projectile.bullet_sprite = projectile_settings.sprite_frames
		projectiles_parent.add_child(new_projectile)
		#get_tree().get_current_scene().projectile_count += 1
		Global.projectile_count += 1

		angle += angle_between_volleys
		offset += projectile_volley_offset
