extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("createOriginalTiles")
	
func createOriginalTiles():
	for tile in $TileMapLayer.get_used_cells():
		original_tiles.append(tile)
		$TileMapLayer.erase_cell(tile)

var direction : Vector2i = Vector2i.UP
var original_tiles: Array[Vector2i]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		direction = Vector2i.UP
	elif Input.is_action_just_pressed("ui_left"):
		direction = Vector2i.LEFT
	elif Input.is_action_just_pressed("ui_down"):
		direction = Vector2i.DOWN
	elif Input.is_action_just_pressed("ui_right"):
		direction = Vector2i.RIGHT

	find_victims(direction)
		
func find_victims(direction:Vector2i) -> Array:
	var victims = []
	var newTiles = find_new_tiles_position(direction)
	for tile in $TileMapLayer.get_used_cells():
		$TileMapLayer.set_cell(tile,-1)
	for newTile in newTiles:
		$TileMapLayer.set_cell(newTile,0,Vector2i(0, 0),1)
		
	return victims
func find_new_tiles_position(direction:Vector2i) -> Array[Vector2i]:
	var newTiles :  Array[Vector2i] = []
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
		newTiles.append(newTile)
	return newTiles
