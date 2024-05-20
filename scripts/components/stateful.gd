class_name StatefulComponent
extends BaseComponent

@export var debug: bool
@export var retreat_state: State
@export_enum("BeforeMidboss", "SecondBoss", "Midboss", "Boss", "None") var retreat_phase: String = "None"

const COMPONENT_NAME := &"StatefulComponent"

func get_component_name() -> StringName:
	return COMPONENT_NAME

#var current_state: String = ""
var current_level: BaseLevel
var current_state: State = null
var state_to_state_map = {}
var state_list = []

var first_state: String = ""

func _ready():
	#super._ready()
	for child in get_children():
		if child is Label:
			continue
		child.target = target
		state_list.append(child)
		state_to_state_map[child.name] = child
		if not first_state:
			# Initialize to the first child state
			first_state = child.name
	LevelProvider.on_level_initialized(func(level: BaseLevel):
		current_level = level
		level.level_phase_changed.connect(on_level_phase_changed))

func on_level_phase_changed():
	var new_phase = current_level.current_phase
	if new_phase == retreat_phase:
		assert(retreat_state, "Retreat state not set when retreat phase is set")
		change_state(retreat_state.name)

# Initialize the state machine by giving each child state a reference to the
func init():
	#print("initializing state machine")
	if not current_state:
		change_state(first_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: String) -> void:
	if current_state:
		current_state.exit()
		
	if debug:
		$Label.text = new_state
	
	current_state = state_to_state_map[new_state]
	assert(current_state)
	current_state.enter()

func get_next_state() -> String:
	# This allows some reuse of states and uses the node tree to determine some state transitions
	var idx = state_list.find(current_state)
	if idx+1 < state_list.size():
		return state_list[idx + 1].name
	else:
		return state_list[0].name


func _process(delta: float):
	if current_state:
		var new_state = current_state.process_frame(delta)
		if new_state:
			if new_state == "next":
				change_state(get_next_state())
			else:
				change_state(new_state)
