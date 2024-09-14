extends Node

signal player_moved(player: Player)
signal enemy_moved
signal enemy_added(enemy: Enemy)

var map: TileMapLayer
var entities: TileMapLayer
var walls: TileMapLayer
signal character_moved(player: Player)
signal weapon_picked_up(weapon: GameplayWeapon,pickup: Pickup)

func get_all_enemies() -> Array[Enemy]:
	var all_enemies : Array[Enemy] = []
	var all_entities = entities.get_children()
	for ent in all_entities:
		if ent.is_in_group("enemies") and all_enemies.has(ent) == false:
			all_enemies.append(ent)
			#print("enemy found")
	
	return all_enemies
