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
## Initial speed of the bullet
@export var initial_velocity: float = 10.0
## Initial direction of the bullets
@export var initial_direction: Vector2 = Vector2(0, 1)

@export_group("Spawner movement")
@export var spawner_moving: bool = false
## range of movement for the spawner
@export var movement_range: float = 0.0
