extends State

var turn_number: int = 0

func enter(_previous_state_path: String, data := {}) -> void:
	if data.has("turn"):
		turn_number = data["turn"]
		
func turn_ended() -> void:
		turn_number += 1
		#print("angry")
		#print(turn_number)
		#print("IM FUCKING ANGRY NOW BITCH")
		if not len(Global.spawners) > 0: return
		Global.spawners.pick_random().spawn(true)

func reset():
	finished.emit("Idle",{"turn":turn_number})
