extends Node

var map: TileMapLayer
var entities: TileMapLayer
var walls: TileMapLayer
signal character_moved(player: Player)
signal weapon_picked_up(weapon: Weapon)
