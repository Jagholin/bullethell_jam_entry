extends Area2D
class_name Projectile

#region stuff for dealing with components. You can copypaste this into any script, since gdscript doesnt support anything fancy to make this easier
# TO FIND any other instance of this code, search for "component_registry" in all files
var components: Dictionary = {}

func register_component(component: BaseComponent):
	components[component.get_component_name()] = component

func get_component(component_name: StringName) -> BaseComponent:
	return components[component_name]
#endregion

var direction: Vector2
var velocity: float

# Called when the node enters the scene tree for the first time.
func _ready():
	# old API
	# connect("body_entered", damage)
	# new API
	body_entered.connect(damage)


func damage(body: Node2D):
	# var damageable := body.get_node("DamageableComponent") as DamageableComponent
	if not body.has_method(&"get_component"):
		return

	var damageable := body.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	if damageable:
		damageable.damage()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position += direction * velocity
