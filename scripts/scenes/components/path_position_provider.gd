class_name PathPositionProviderComponent
extends BaseComponent

const COMPONENT_NAME := &"PathPositionProviderComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

@export var path: Curve2D
@export var velocity: float = 100.0

var accumulated_time: float = 0.0
var accumulated_distance: float = 0.0
var previous_reading: Vector2

var first_run: bool = true

func get_next_position_delta( delta: float ) -> Vector2:
	assert(path != null, "PathPositionProviderComponent: Path is not set")
	if first_run:
		previous_reading = path.sample_baked(0.0)
		first_run = false
	accumulated_time += delta
	accumulated_distance += velocity * delta
	var next_reading = path.sample_baked(accumulated_distance)
	var result = next_reading - previous_reading
	previous_reading = next_reading
	return result

func is_initialised() -> bool:
	return path != null
