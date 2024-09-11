extends State
var turn_number: int = 0
func enter(previous_state_path: String, data := {}) -> void:
	if data.has("turn"):
		turn_number = data["turn"]
func handle_input(_event: InputEvent) -> void:

	if Input.is_action_just_pressed("ui_accept"):
		turn_number += 1
		print("angry")
		print(turn_number)
		print("IM FUCKING ANGRY NOW BITCH")

func reset():
	finished.emit("Idle",{"turn":turn_number})
