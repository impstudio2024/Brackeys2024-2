extends State

var enemy: CharacterBody2D
var player: CharacterBody2D

var size = 128

func manh(pos1, pos2):
	return abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y)

func move():
	var arr = [Vector2.UP * size, Vector2.DOWN * size, Vector2.RIGHT * size, Vector2.LEFT * size]
	enemy.position += arr[randi_range(0, arr.size() - 1)] 

func enter(previous_state_path: String, data := {}) -> void:
	player.connect("end_turn", move)
	
func exit():
	player.disconnect("end_turn", move)

func _process(delta: float) -> void:
	if manh(enemy.position, player.position) < size * 6:
		finished.emit(self, "ChasingState")
