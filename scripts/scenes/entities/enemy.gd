extends Area2D
class_name Enemy

@export var end_game_screen: bool = false

#region stuff for dealing with components. You can copypaste this into any script, since gdscript doesnt support anything fancy to make this easier
# TO FIND any other instance of this code, search for "component_registry" in all files
var components: Dictionary = {}

func register_component(component: BaseComponent):
	components[component.get_component_name()] = component

func get_component(component_name: StringName) -> BaseComponent:
	if components.has(component_name):
		return components[component_name]
	return null
#endregion

signal boss_destroyed

#region pass projectile parent to the child component
# THERE ARE OTHER INSTANCES of this code, search for "projectile_parent_pass" in all files to find them
@export var projectile_parent: Node2D:
	set(new_value):
		if projectile_parent == new_value:
			return
		projectile_parent = new_value
		# spawner is ProjectileSpawnerComponent or something with similar interface
		if spawner:
			spawner.projectiles_parent = projectile_parent
		for child in get_children():
			if child is Enemy:
				child.projectile_parent = projectile_parent

#endregion
@onready var spawner: ProjectileSpawnerComponent = $ProjectileSpawner
@onready var state_machine: StatefulComponent = $Stateful
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@export var projectile_configs: Array[ProjectileSpawnerConfigResource]
@export var path: Path2D
@export var retreat_path: Path2D
# @export var retreat_state: State
@export_enum("BeforeMidboss", "Midboss", "SecondBoss", "Boss", "None") var retreat_phase: String = "None"

var resume_scroll_on_death: bool = false
var level: BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	LevelProvider.on_level_initialized(func(l: BaseLevel): level = l)
	if projectile_configs:
		spawner.bullet_configs = projectile_configs
	spawner.projectiles_parent = projectile_parent
	# var notifier := $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D
	if notifier != null:
		notifier.screen_entered.connect(state_machine.init)
		notifier.screen_exited.connect(queue_free)
	if path:
		var positionProvider := get_component(PathPositionProviderComponent.COMPONENT_NAME) as PathPositionProviderComponent
		assert(positionProvider, "Setting path without PathPositionProviderComponent won't work")
		positionProvider.path = path.curve
	if state_machine and retreat_phase != "None":
		state_machine.retreat_phase = retreat_phase
		# state_machine.retreat_state = retreat_state
	if retreat_path:
		assert(state_machine, "Setting retreat path without state machine won't work")
		var positionProvider := get_component(PathPositionProviderComponent.COMPONENT_NAME) as PathPositionProviderComponent
		assert(positionProvider, "Setting retreat path without PathPositionProviderComponent won't work")
		state_machine.retreat_state.path = retreat_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func destroy():
	if end_game_screen:
		boss_destroyed.emit()
		Global.end_screen= true
	Global.enemies_destroyed_count += 1
	Global.check_progress()
	if ExplosiveComponent.COMPONENT_NAME in components:
		components[ExplosiveComponent.COMPONENT_NAME].explode()
	if resume_scroll_on_death:
		level.resume_scroll()
	queue_free()

