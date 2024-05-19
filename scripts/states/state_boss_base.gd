extends StateEnemyDefault
class_name StateBossBase

var current_level: BaseLevel

func _ready():
	#super._ready()
	LevelProvider.on_level_initialized(func(level: BaseLevel): current_level = level)

func process_frame(delta: float) -> String:
	super.process_frame(delta)
	target.position += Vector2.UP * current_level.level_scroll_speed * delta # this needs to match the level's scrolling speed
	return ""
