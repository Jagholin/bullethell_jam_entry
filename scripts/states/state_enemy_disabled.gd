extends State
class_name StateEnemyDisabled

@export var introduction_delay = 1.0

func get_animation_name() -> String:
	return "introduction"



func process_frame(delta: float) -> String:
	super.process_frame(delta)
	if elapsed>introduction_delay:
		return "next"
	return ""
