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
#endregion

@export var SPEED: float = 100000.0
@export var ACCELERATION: float = 1000.0
@export var BOUNCE_ABSORTION: float = 0.5
@export var IMPACT_ENERGY: float = 10

var level_velocity: Vector2
var attached_npcs: Array[RigidBody2D] = []

@onready var spawner: ProjectileSpawnerComponent = $ProjectileSpawner

func _exit_tree():
	# we are exiting the tree, so deregister from the provider
	PlayerProvider.set_player(null)

func _ready():
	spawner.projectiles_parent = projectile_parent
	self.set_motion_mode(CharacterBody2D.MOTION_MODE_FLOATING)

	PlayerProvider.set_player(self)

func _input(event):
	if event.is_action_pressed(&"fire"):
		spawner.active = true
	if event.is_action_released(&"fire"):
		spawner.active = false

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
	move_and_collide(level_velocity * delta)

func attach_npc(npc: RigidBody2D):
	#var newSpring := DampedSpringJoint2D.new()
	#newSpring.node_a = get_path()
	#newSpring.node_b = npc.get_path()
	#newSpring.rest_length = 30
	#newSpring.length = 100
	#add_child(newSpring)
	attached_npcs.push_back(npc)
