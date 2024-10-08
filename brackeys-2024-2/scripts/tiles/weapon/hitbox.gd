extends TileMapLayer

#@onready var hitboxes = $"."
var original_tiles  = []
# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("connect_children")
	
func connect_children():
	createOriginalTiles()
	for child in get_children():
		child.name = str(local_to_map(child.position))
		child.body_entered.connect(_on_body_entered)

func createOriginalTiles():
	for tile in get_used_cells():
		original_tiles.append(tile)

func update_hitbox_positions(direction:Vector2i):
	var newTiles = find_new_tiles_position(direction)
	for child in newTiles:
		var childNode = get_node(str(child))
		childNode.position = map_to_local(newTiles[child])

func find_new_tiles_position(direction:Vector2i) -> Dictionary:
	var newTiles :  Dictionary
	for tilePos in original_tiles:
		var newTile = Vector2i.ZERO
		match direction:
			Vector2i.UP:
				newTile = Vector2i(tilePos.y,-tilePos.x)
			Vector2i.LEFT:
				newTile = Vector2i(-tilePos.x, tilePos.y)
			Vector2i.DOWN:
				newTile = Vector2i(-tilePos.y, tilePos.x)
			Vector2i.RIGHT:
				newTile = Vector2i(tilePos.x, tilePos.y)
		newTiles[tilePos] = newTile
	return newTiles


func _on_body_entered(_body):
	pass # Replace with function body.
