extends Area2D
class_name PowerUp

# TODO not sure why this broke all the resources
#@export var item: ItemSettingsResource
@export var item: String

func _ready():
	area_entered.connect(collect)
	body_entered.connect(collect)

func collect(body):
	# body can be either Node2D(CollisionObject2D) or Area2D
	# var damageable := body.get_node("DamageableComponent") as DamageableComponent
	if not body.has_method(&"get_component"):
		## TODO: do we want to do assert() here to break into debugger immediately?
		print("Projectile.damage failed: body doesn't implement get_component method")
		return

	if CollectorComponent.COMPONENT_NAME in body.components:
		var collector := body.components[CollectorComponent.COMPONENT_NAME] as CollectorComponent
		collector.collect(item)
		queue_free()
