extends Node2D
@onready var state_machine = $StateMachine

var enemies: Array[Enemy] = []

func _ready() -> void:
	Global.enemy_added.connect(_on_enemy_added)
	Global.player_moved.connect(_on_player_moved)
	
func _on_enemy_added(enemy: Enemy):
	enemies.append(enemy)
	print(enemy)
	 
func _on_player_moved(player: Player):
	for enemy in enemies:
		await enemy.on_enemy_turn(player)
	state_machine.state.turn_ended()
	Global.enemy_moved.emit()
