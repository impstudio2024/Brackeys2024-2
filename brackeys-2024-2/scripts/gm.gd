extends Node2D

var enemies: Array[Enemy] = []

@export var angry_after_turns: int = 20

@onready var state_machine = $StateMachine

func _ready() -> void:
	Global.enemy_added.connect(_on_enemy_added)
	Global.player_moved.connect(_on_player_moved)
	
func _on_enemy_added(enemy: Enemy):
	enemies.append(enemy)
	print(enemy)
	 
func _on_player_moved(player: Player):
	var to_remove: Array[int]
	for i  in range(len(enemies)):
		var enemy = enemies[i]
		if not enemy:
			to_remove.append(i)
			continue
		enemy.on_enemy_turn(player)
		await get_tree().process_frame
		
	state_machine.state.turn_ended()
	
	# remove any enemies that we deleted
	for index in to_remove:
		enemies.remove_at(index)
		
	Global.enemy_moved.emit()
