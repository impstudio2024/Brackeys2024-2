extends State

var turn_number: int = 0

## Called by the state machine when receiving unhandled input events.
func handle_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		turn_number += 1
		print("idle")
		print(turn_number)
		if turn_number == 20:
			finished.emit("Angry",{"turn":turn_number})
