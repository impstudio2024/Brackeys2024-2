extends Node

signal player_moved(player: Player)
signal enemy_moved
signal enemy_added(enemy: Enemy)

var map: TileMapLayer
var entities: TileMapLayer
var walls: TileMapLayer
signal character_moved(player: Player)
signal weapon_picked_up(weapon: Weapon)
