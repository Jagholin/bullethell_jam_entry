class_name BulletPatternResource
extends Resource

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
## Rotation speed of center of the volley, in degrees per second
@export var volley_rotation_speed: float = 0.0
## Initial speed of the bullet
@export var initial_velocity: float = 10.0
## Initial direction of the bullets
@export var initial_direction: Vector2 = Vector2(0, 1)
## Tendency to shoot towards the player, 0 is no tendency, 1 is shoot directly at the player (1 will override angle_offset and volley_rotation_speed)
## can also be anything in between, will linearly interpolate between the two
@export var shoot_at_player_tendency: float = 0.0
## If angle_offset should be randomized, and the spread of the randomization(in degrees)
@export var randomized_angle_spread: float = 0.0
## If the initial velocity should be randomized, and the extent of the randomization
@export var randomized_velocity_spread: float = 0.0

enum EmitionType { PROJECTILE, SPAWNPOINT }
## Primary emition type
@export var emition_type: EmitionType = EmitionType.PROJECTILE
## Chained bullet pattern to spawn from spawnpoints
@export var chained_bullet_pattern: BulletPatternResource = null
## Lifetime of a spawnpoint, in seconds
@export var spawnpoint_lifetime: float = 5.0

@export_group("Spawner movement")
@export var spawner_moving: bool = false
## range of movement for the spawner
@export var movement_range: float = 0.0
