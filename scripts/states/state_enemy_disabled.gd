extends State
class_name StateEnemyDisabled

@export var introduction_delay = 1.0
@export var block_scrolling = false

func get_animation_name() -> String:
	return "introduction"



func process_frame(delta: float) -> String:
	super.process_frame(delta)
	if elapsed>introduction_delay:
		return "next"
	return ""


func exit() -> void:
	super.exit()
	var damageable := target.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	damageable.immune = false
	var spawner := target.get_component(ProjectileSpawnerComponent.COMPONENT_NAME) as ProjectileSpawnerComponent
	spawner.active = true
	
	if block_scrolling:
		get_tree().current_scene.level_scroll_speed = 0
