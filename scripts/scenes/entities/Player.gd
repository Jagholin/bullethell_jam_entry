extends CharacterBody2D
class_name Player

@export var SPEED: float = 100000.0
@export var ACCELERATION: float = 1000.0
@export var BOUNCE_ABSORTION = 0.5
@export var IMPACT_ENERGY = 10

func _ready():
	self.set_motion_mode(CharacterBody2D.MOTION_MODE_FLOATING)

func _physics_process(delta):
	var direction: Vector2
	direction = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x, SPEED * direction.x, ACCELERATION*delta)
	velocity.y = move_toward(velocity.y, SPEED * direction.y, ACCELERATION*delta)
	
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var other = collision_info.get_collider() as RigidBody2D
		if other:
			other.apply_impulse(-1*collision_info.get_normal()*IMPACT_ENERGY)
		velocity = velocity.bounce(collision_info.get_normal()) * BOUNCE_ABSORTION
