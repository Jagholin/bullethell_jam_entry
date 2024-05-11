extends CharacterBody2D
class_name Player

#region stuff for dealing with components. You can copypaste this into any script, since gdscript doesnt support anything fancy to make this easier
# TO FIND any other instance of this code, search for "component_registry" in all files
var components: Dictionary = {}

func register_component(component: BaseComponent):
	components[component.get_component_name()] = component

func get_component(component_name: StringName) -> BaseComponent:
	return components[component_name]
#endregion

@export var SPEED: float = 100000.0
@export var ACCELERATION: float = 1000.0
@export var BOUNCE_ABSORTION: float = 0.5
@export var IMPACT_ENERGY: float = 10

func _ready():
	self.set_motion_mode(CharacterBody2D.MOTION_MODE_FLOATING)

func _physics_process(delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")

	velocity.x = move_toward(velocity.x, SPEED * direction.x, ACCELERATION*delta)
	velocity.y = move_toward(velocity.y, SPEED * direction.y, ACCELERATION*delta)
	
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var other := collision_info.get_collider() as RigidBody2D
		if other:
			other.apply_impulse(-1.0 * collision_info.get_normal() * IMPACT_ENERGY)
		velocity = velocity.bounce(collision_info.get_normal()) * BOUNCE_ABSORTION
