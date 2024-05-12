extends Area2D
class_name PowerUp

#@export var item: ItemSettingsResource

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

	var collector := body.get_component(CollectorComponent.COMPONENT_NAME) as CollectorComponent
	if collector:
		pass
		#collector.collect(item)
