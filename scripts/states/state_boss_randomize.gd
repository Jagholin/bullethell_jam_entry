extends StateBossBase
class_name StateBossRandomize


func process_frame(delta: float) -> String:
	super.process_frame(delta)
	
	var sample = randf()
	if sample < 0.33:
		#return "StateBossMirror"
		return "StateFiring"
	elif sample < 0.66:
		return "StateBossHoming"
	else:
		return "StateBossHealing"
	@warning_ignore("unreachable_code")
	assert(false, "This code should be unreachable")
