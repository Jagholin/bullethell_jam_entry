extends Area2D
class_name Projectile

var direction: Vector2
var velocity: float

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", damage)


func damage(body: Node2D):
	var damageable = body.get_node("Damageable") as Damageable
	if damageable:
		damageable.damage()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * velocity
