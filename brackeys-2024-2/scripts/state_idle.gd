extends State

var turn_number: int = 0
signal we_gettin_angry

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		turn_number += 1
		print(turn_number)
		if turn_number == 20:
