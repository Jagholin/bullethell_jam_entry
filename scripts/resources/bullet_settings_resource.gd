class_name BulletSettingsResource
extends Resource

enum BulletType { ENEMY_BULLET, PLAYER_BULLET }
## The type of bullet this is, either an enemy bullet or a player bullet.
@export var bullet_type: BulletType

## Sprite to use for the bullet.
@export var sprite_frames: SpriteFrames

## Initial speed of the bullet
@export var initial_velocity: float = 10.0

## Initial direction of the bullets
@export var initial_direction: Vector2 = Vector2(0, 1)

func get_collision_mask() -> int:
	# set the collision mask.
	# bits:
	# 1       : player
	# 10      : enemy
	# 10000   : obstacles
	if bullet_type == BulletType.ENEMY_BULLET:
		return 0b00010101
	else:
		return 0b00010010
