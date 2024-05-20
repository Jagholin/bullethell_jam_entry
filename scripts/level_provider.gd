extends Node

var level: BaseLevel:
	set(newValue):
		if level == newValue:
			return
		level = newValue
		if not level:
			level_destroyed.emit()
		else:
			level_changed.emit(level)

signal level_changed(level: BaseLevel)
signal level_destroyed

func on_level_initialized(cb: Callable):
	if not level:
		await level_changed
	cb.call(level)

func set_level(newLevel: BaseLevel):
	level = newLevel