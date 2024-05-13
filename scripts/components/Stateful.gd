class_name StatefulComponent
extends BaseComponent


const COMPONENT_NAME := &"StatefulComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

var current_state: String = ""
var state_to_state_map = {}
var state_list = []
# Initialize the state machine by giving each child state a reference to the
func init():
	print("initializing state machine")
	for child in get_children():
		child.target = target
		state_list.append(child.name)
		state_to_state_map[child.name] = child
		if current_state=="":
			# Initialize to the first child state
			change_state(child.name)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: String) -> void:
	if current_state:
		state_to_state_map[current_state].exit()
	
	current_state = new_state
	var state = state_to_state_map[current_state]
	state.elapsed=0
	state.enter()

func get_next_state():
	var idx = state_list.find(current_state)
	if idx+1 < state_list.size():
		return state_list[idx + 1]
	else:
		return state_list[0]


func _process(delta: float):
	if current_state:
		var state := state_to_state_map[current_state] as State
		var new_state = state.process_frame(delta)
		if new_state:
			change_state(new_state)
