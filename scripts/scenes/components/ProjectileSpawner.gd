extends Node2D

@export var interval: float = 0.5
@export var projectile: PackedScene

var elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	elapsed += delta
	if elapsed >= interval:
		fire()
		elapsed = 0


func fire():
	var new_projectile = projectile.instantiate() as Projectile
	new_projectile.direction = Vector2(0,1)
	new_projectile.velocity = 10
	new_projectile.global_position = global_position
	get_tree().get_current_scene().get_node("Projectiles").add_child(new_projectile)

	
