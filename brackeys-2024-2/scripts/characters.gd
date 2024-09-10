extends CharacterBody2D

class_name Character


var map_position: Vector2i
signal character_moved # Create a signal for the character having moved

func _ready() -> void:
	add_to_group('character')
	map_position = Global.entities.local_to_map(position)

func move(relative_movement: Vector2i) -> Character:
	if Global.entities.get_cell_source_id(map_position + relative_movement):
		for character in get_tree().get_nodes_in_group('character'):
			if not character.map_position == map_position + relative_movement: continue
			return character as Character


	# move the character
	position = Global.entities.map_to_local(map_position + relative_movement)
	Global.emit_signal("character_moved")
	# when moving the map position will also need to be updated
	map_position = Global.entities.local_to_map(position)
	return null



func _on_character_moved() -> void:
	print("Character moved!") # Print a message when character moves for debugging
