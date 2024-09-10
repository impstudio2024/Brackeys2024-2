extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var state_machine = $StateMachine
	state_machine.connect("moar_enemies", Callable(self, "_on_state_machine_moar_enemies"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_state_machine_moar_enemies():
	print("Received petition to send moar enemies into the fight")
	print('Enemy 1: "You can count with my bow!"')
	print('Enemy 2: "And my axe!"')
	print('Enemy 1: "And my self esteem! Oh no, wait..."')
