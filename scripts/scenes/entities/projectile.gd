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

@export var bullet_sprite: SpriteFrames:
	set(new_value):
		if bullet_sprite == new_value:
			return
		bullet_sprite = new_value
		if animated_sprite:
			animated_sprite.sprite_frames = bullet_sprite

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2
var velocity: float

# Called when the node enters the scene tree for the first time.
func _ready():
	# old API
	# connect("body_entered", damage)
	# new API
	area_entered.connect(damage)
	body_entered.connect(damage)
	if bullet_sprite:
		animated_sprite.sprite_frames = bullet_sprite

func damage(body):
	# body can be either Node2D(CollisionObject2D) or Area2D
	# var damageable := body.get_node("DamageableComponent") as DamageableComponent
	if not body.has_method(&"get_component"):
		## TODO: do we want to do assert() here to break into debugger immediately?
		print("Projectile.damage failed: body doesn't implement get_component method")
		return

	var damageable := body.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
	if damageable:
		var damageResult := damageable.damage()
		# remove the projectile if this was a hit
		if damageResult == DamageableComponent.DamageResult.HIT:
			queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * velocity * 60 * delta 
	# TODO: temporary solution, we should probably have a better way to handle this
	if position.x < 0 or position.x > 1200 or position.y < 0 or position.y > 800:
		queue_free()
