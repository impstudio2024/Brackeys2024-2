extends Node

signal player_moved(player: Player)
signal enemy_moved
signal enemy_added(enemy: Enemy)
signal character_moved(player: Player)
signal weapon_picked_up(weapon: Weapon)

var map: TileMapLayer
var entities: TileMapLayer
var walls: TileMapLayer
var holes: TileMapLayer
var specials: TileMapLayer

enum SpecialTileTypes{
	EXIT = 0
}

var level_paths: Array[String] = []
var current_level: int = 0

# call this when entering the game.
func advance_level():
	get_tree().change_scene_to_file(level_paths[current_level])
	current_level += 1
