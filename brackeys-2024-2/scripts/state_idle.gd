extends State


var turn_number: int = 0

## Called by the state machine when receiving unhandled input events.
func turn_ended() -> void:
		turn_number += 1
		#print('idle====================='+str(turn_number))
		if turn_number >= state_machine_owner.angry_after_turns:
			finished.emit("Angry",{"turn":turn_number})
