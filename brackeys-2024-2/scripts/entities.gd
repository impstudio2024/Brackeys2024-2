extends TileMapLayer


var enemies_move: Array = []


func add_enemy_move(enemy: Enemy, new_pos: Vector2):
	var arr = [enemy, new_pos]
	enemies_move.push_back(arr)
	if enemies_move.size() > 0 && enemies_move.size() == get_tree().get_nodes_in_group("enemy").size():
		for i in range(enemies_move.size()):
			enemies_move[i][0].position = enemies_move[i][1]
		enemies_move.clear()
