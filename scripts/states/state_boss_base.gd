extends StateEnemyDefault
class_name StateBossBase


func process_frame(delta: float) -> String:
	super.process_frame(delta)
	target.position += Vector2.UP * get_tree().current_scene.level_scroll_speed * delta # this needs to match the level's scrolling speed
	return ""
