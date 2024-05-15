extends State
class_name StateEnemyDisabled

func get_animation_name() -> String:
	return "introduction"



func process_frame(delta: float) -> String:
	super.process_frame(delta)
	if elapsed>1:
		return "next"
	return ""
