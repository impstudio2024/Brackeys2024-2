extends State

var turn_number: int = 0

## Called by the state machine when receiving unhandled input events.
func turn_ended() -> void:
		turn_number += 1
		print("idle")
		print(turn_number)
		if turn_number == 20:
			finished.emit("Angry",{"turn":turn_number})
