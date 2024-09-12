extends State

var size = 16
@export var detection_range = 5

func manh(pos1: Vector2, pos2: Vector2):
	return abs(pos1.x - pos2.x) + abs(pos1.y - pos2.y)

func move(player: Player, enemy: Enemy):
	var arr = [Vector2.UP , Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT, Vector2.ZERO]
	var chosen_dir = arr[randi_range(0, arr.size() - 1)] 
	await state_machine_owner.move(chosen_dir)
	if manh(Global.entities.local_to_map(enemy.position), Global.entities.local_to_map(player.position)) < size * detection_range:
		finished.emit("ChasingState")


func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	
func exit():
	pass

func update(_delta: float) -> void:
	pass
	
