class_name EnemySpawner
extends BaseComponent

const COMPONENT_NAME := &"EnemySpawner"

func get_component_name() -> StringName:
	return COMPONENT_NAME

@export_group("Enemy spawn settings")
## Interval between each enemy spawned
@export var interval: float = 5

@export var enemy: PackedScene

## Whether the spawner is currently active and emitting enemies
@export var active: bool = true

var elapsed: float = 0.0


func _ready():
	pass


func _process(delta):
	if not active:
		elapsed = 0
		return
	elapsed += delta
	while elapsed >= interval:
		fire()
		elapsed -= interval


func fire():
	var new_enemy := enemy.instantiate() as Enemy
	new_enemy.projectile_parent = get_tree().get_current_scene().get_node("Projectiles")
	get_parent().add_child(new_enemy)
	var tween := create_tween() as Tween
	new_enemy.global_position = global_position
	tween.tween_property(new_enemy, "global_position", Vector2(randf()*get_viewport_rect().size.x, randf()*get_viewport_rect().size.y), 1.0)
	tween.play()
	
