extends State

var enemy: CharacterBody2D
var player: CharacterBody2D

var size = 128

func Manh(pos1, pos2):
	return abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y)

func Move():
	var arr = [Vector2.UP * size, Vector2.DOWN * size, Vector2.RIGHT * size, Vector2.LEFT * size]
	enemy.position += arr[randi_range(0, arr.size() - 1)] 

func Enter():
	player.connect("end_turn", Move)
	
func Exit():
	player.disconnect("end_turn", Move)

func _process(delta: float) -> void:
	if Manh(enemy.position, player.position) < size * 6:
		Transitioned.emit(self, "ChasingState")
