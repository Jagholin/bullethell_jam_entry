extends Projectile


var player: Player
@export var accuracy: float = 3

func _ready():
	super._ready()
	# player = get_tree().current_scene.get_node("Player")
	PlayerProvider.on_player_initialized(func(p: Player): player = p)
	$AnimatedSprite2D.play()

func _process(delta):
	direction = lerp(direction, (player.global_position - global_position).normalized(), accuracy*delta)
	position += direction * velocity * 30 * delta 
