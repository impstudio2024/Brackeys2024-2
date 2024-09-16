extends Node

signal player_moved(player: Player)
signal enemy_moved
signal enemy_added(enemy: Enemy)
signal character_moved(player: Player)
signal weapon_picked_up(weapon: GameplayWeapon,pickup: Pickup)
signal game_over()
signal enemy_killed
signal attack(target: Character, damage: int)
signal player_health_changed(health: int)

signal playGame()
signal seeCredits()
signal backMenu()
signal angryGM()
signal idleGM()
signal startBGM()
signal levelClear()
signal retry()

var map: TileMapLayer
var entities: TileMapLayer
var entity_positions: TileMapLayer
var walls: TileMapLayer
var holes: TileMapLayer
var specials: TileMapLayer

var spawners: Array[Spawner] = []

enum SpecialTileTypes{
	EXIT = 0
}

var level_paths: Array[String] = [
	"res://Scenes/levels/level1new.tscn",
	"res://Scenes/levels/level2.tscn",
	"res://Scenes/levels/level3.tscn",
	"res://Scenes/levels/level4.tscn",
	"res://Scenes/levels/level5.tscn",
	"res://Scenes/levels/level6.tscn",
	"res://Scenes/levels/level7.tscn",
	"res://Scenes/levels/level8.tscn",
	"res://Scenes/levels/level9.tscn"
]
var current_level: int = 0

func reset_spawners():
	spawners = []

# call this when entering the game.
func advance_level():
	get_tree().change_scene_to_file(level_paths[current_level])
	current_level += 1
	reset_spawners()
