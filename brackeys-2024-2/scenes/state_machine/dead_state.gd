extends State

var enemy: Enemy

func enter(_previous_state_path: String, data := {}) -> void:
	enemy = data["enemy"]
	Global.entity_positions.erase_cell(enemy.map_position)
	enemy.get_node("CollisionShape2D").disabled = true
	enemy.visible = false
	enemy.map_position = Global.entities.local_to_map(enemy.initial_pos)
	enemy.position = enemy.initial_pos

func exit():
	enemy.get_node("CollisionShape2D").disabled = false
	enemy.visible = true
	


func update(_delta: float) -> void:
	pass
