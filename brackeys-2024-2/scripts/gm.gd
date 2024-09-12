extends Node2D

var enemies: Array[Enemy] = []

func _ready() -> void:
	print('ready')
	Global.enemy_added.connect(_on_enemy_added)
	Global.enemies_turn.connect(enemies_turn.bind())
	
func _on_enemy_added(enemy: Enemy):
	enemies.append(enemy)
	print(enemy)
	
func enemies_turn():
	print('enemies turn')
	for enemy in enemies:
		enemy.on_enemy_turn()
		print(enemy)
	
	Global.players_turn.emit()
