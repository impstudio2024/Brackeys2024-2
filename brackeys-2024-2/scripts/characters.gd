extends CharacterBody2D

class_name Character


var map_position: Vector2i


func _ready() -> void:
	add_to_group('character')
	map_position = Global.entities.local_to_map(position)
	print(name + ", position " + str(map_position))


func move(relative_movement: Vector2i) -> Character:
	print('\n' + name + ' at ' + str(map_position)+ ' is moving')
	print("movement is " + str(relative_movement))
	print('destination is ' + str(map_position + relative_movement))
	print('source id is ' + str(Global.entities.get_cell_source_id(map_position + relative_movement)))

	# we are basically not using the tilemmaplayers functionality becasuse it breaks everything. for explanation message @Malario
	for character in get_tree().get_nodes_in_group('character'):
		if not character.map_position == map_position + relative_movement: continue
		return character as Character


	if Global.walls.get_cell_tile_data(map_position + relative_movement): return null

	# move the character
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "position", Global.entities.map_to_local(map_position + relative_movement), .1)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.play()
	await tween.finished
	# when moving the map position will also need to be updated
	map_position = Global.entities.local_to_map(position)
	
	if Global.holes.get_cell_tile_data(map_position + relative_movement) and not is_in_group('player'): 
		queue_free()
	
	return null
