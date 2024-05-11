extends Area2D
class_name Enemy

#region stuff for dealing with components. You can copypaste this into any script, since gdscript doesnt support anything fancy to make this easier
# TO FIND any other instance of this code, search for "component_registry" in all files
var components: Dictionary = {}

func register_component(component: BaseComponent):
	components[component.get_component_name()] = component

func get_component(component_name: StringName) -> BaseComponent:
	return components[component_name]
#endregion

@export var projectile_parent: Node2D:
	set(new_value):
		if projectile_parent == new_value:
			return
		projectile_parent = new_value
		if spawner:
			spawner.projectiles_parent = projectile_parent
@onready var spawner: ProjectileSpawnerComponent = $ProjectileSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner.projectiles_parent = projectile_parent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
