extends Node2D
class_name GameplayWeapon

@onready var hitbox_grid = $TileMapLayer
func move(relative_direction):
	var newTiles = hitbox_grid.find_new_tiles_position(relative_direction)
	for child in newTiles:
		var childNode = hitbox_grid.get_node(str(child))
		childNode.position = hitbox_grid.map_to_local(newTiles[child])
