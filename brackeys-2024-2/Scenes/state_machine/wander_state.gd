extends State

var enemy: CharacterBody2D
var player: CharacterBody2D

var size = 16

func manh(pos1, pos2):
	return abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y)

func move():
	var arr = [Vector2.UP , Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT, Vector2.ZERO]
	var chosen_dir = arr[randi_range(0, arr.size() - 1)] 
	state_machine_owner.move(chosen_dir)
 	#if manh(enemy.position, player.position) < size * 6:
	#	finished.emit(self, "ChasingState")


func enter(previous_state_path: String, data := {}) -> void:
	player.connect("end_turn", move)
	
func exit():
	player.disconnect("end_turn", move)

func update(_delta: float) -> void:
	pass
	
