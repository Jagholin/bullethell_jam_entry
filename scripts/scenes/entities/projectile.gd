extends Area2D
class_name Projectile

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

func _ready():
	area_entered.connect(damage)
	body_entered.connect(damage)
	if bullet_sprite:
		animated_sprite.sprite_frames = bullet_sprite

func damage(body):
	# body can be either Node2D(CollisionObject2D) or Area2D
	# var damageable := body.get_node("DamageableComponent") as DamageableComponent
	if not body.has_method(&"get_component"):
		## TODO: do we want to do assert() here to break into debugger immediately?
		print("Projectile.damage failed: body %s doesn't implement get_component method" % str(body.get_path()))
		return

	if DamageableComponent.COMPONENT_NAME in body.components:
		var damageable := body.get_component(DamageableComponent.COMPONENT_NAME) as DamageableComponent
		var damageResult := damageable.damage()
		# remove the projectile if this was a hit
		if damageResult == DamageableComponent.DamageResult.HIT:
			destroy()
	elif GrazeComponent.COMPONENT_NAME in body.components:
		Global.grazes_count += 1

func destroy():
	if ExplosiveComponent.COMPONENT_NAME in components:
		components[ExplosiveComponent.COMPONENT_NAME].explode()
	Global.projectile_count -= 1
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * velocity * 60 * delta 
