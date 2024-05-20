extends Area2D
class_name DropOffArea


func _on_body_entered(body):
	if body is Entity:
		print("npc collided with dropoff", body)
		body.attached_to_player = false
		body.apply_impulse(Vector2.RIGHT * 100)

