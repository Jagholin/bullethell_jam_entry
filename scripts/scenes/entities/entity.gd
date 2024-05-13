extends RigidBody2D
class_name Entity

#region stuff for dealing with components. You can copypaste this into any script, since gdscript doesnt support anything fancy to make this easier
# TO FIND any other instance of this code, search for "component_registry" in all files
var components: Dictionary = {}

func register_component(component: BaseComponent):
	components[component.get_component_name()] = component

func get_component(component_name: StringName) -> BaseComponent:
	return components[component_name]
#endregion

@export var magnet_distance: float = 60.0
@export var magnet_coeff: float = 3.4
@export var damping_coeff: float = 0.3
@export var gravity_strength: float = 200.0
@onready var magnet_area: Area2D = $MagnetArea
@onready var damage_component: DamageableComponent = $DamageableComponent
var attached_to_player: bool = false
var player: Player

func destroy():
	if ExplosiveComponent.COMPONENT_NAME in components:
		components[ExplosiveComponent.COMPONENT_NAME].explode()
	queue_free()

func disable_areamagnet():
	magnet_area.process_mode = Node.PROCESS_MODE_DISABLED

func _physics_process(_delta):
	if attached_to_player:
		var dirToPlayer := player.global_position - global_position
		var idealDir := dirToPlayer.normalized() * magnet_distance
		# hooks law
		# maybe use different law here?
		var springForce := (dirToPlayer - idealDir) * magnet_coeff
		var dampingForce := linear_velocity * -damping_coeff
		print("damping force strength: ", dampingForce.length())
		print("spring force strength: ", springForce.length())
		apply_central_force(springForce)
		apply_central_force(dampingForce)
		apply_central_force(Vector2(0, gravity_strength))
		#move_and_collide(player.level_velocity * _delta)

func _on_magnet_area_body_entered(body):
	# body is the player
	var realPlayer := body as Player
	realPlayer.attach_npc(self)
	player = realPlayer
	attached_to_player = true
	damage_component.immune = true
	call_deferred(&"disable_areamagnet")
