extends CharacterBody2D

class_name Character


var map_position: Vector2i


func _ready() -> void:
	add_to_group('character')
	map_position = Global.entities.local_to_map(position)
	print(name + ", position " + str(map_position))
	

func move(relative_movement: Vector2i) -> Character:
	print(relative_movement)
	if Global.entities.get_cell_source_id(map_position + relative_movement):
		for character in get_tree().get_nodes_in_group('character'):
			if not character.map_position == map_position + relative_movement: continue
			return character as Character


	# move the character
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self,"position",Global.entities.map_to_local(map_position + relative_movement),.1)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.play()
	await tween.finished
	# when moving the map position will also need to be updated
	map_position = Global.entities.local_to_map(position)
	return null
