extends Node


@export var initial_state : State

@export var player: CharacterBody2D
@onready var enemy = get_parent()

var current_state : State
var states : Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.Transitioned.connect(on_child_transition)
			child.player = player
			child.enemy = enemy
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state._process(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state._physics_process(delta)
		
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
