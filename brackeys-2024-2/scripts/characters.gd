extends CharacterBody2D
class_name Character

signal health_changed

@onready var health : int = 15:
	set(value):
		health = value
		health_changed.emit()
@onready var damage : int = 5
@onready var animation_player = $AnimationPlayer

var map_position: Vector2i


func _ready() -> void:
	add_to_group('character')
	map_position = Global.entities.local_to_map(position)
	#print(name + ", position " + str(map_position))


func move(relative_movement: Vector2i) -> Character:
	# we are basically not using the tilemmaplayers functionality becasuse it breaks everything. for explanation message @Malario
	
	var character_on_destination: Character = find_character_in_cell(map_position + relative_movement)
	if character_on_destination: return character_on_destination

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
	
	if Global.holes.get_cell_tile_data(map_position) and not is_in_group('player'):
		queue_free()
	elif Global.holes.get_cell_tile_data(map_position) and is_in_group('player'):
		move(relative_movement)
	
	return null
	
func move_and_jump_over(direction: Vector2i):
	var original_direction: Vector2i = direction
	while find_character_in_cell(direction + map_position):
		direction += original_direction
	move(direction)

func find_character_in_cell(cell: Vector2i) -> Character:
	for character in get_tree().get_nodes_in_group('character'):
		if not character.map_position == cell: continue
		return character as Character
	return null
	
func damage_by(damage: int):
	animation_player.play("hurt")
	health -= damage
	#TODO: play animation, maybe a simple red color modulation for a few frames
	if health <= 0:
		send_to_the_backrooms()
	
func send_to_the_backrooms():
	if self.is_in_group("enemies"):
		print("enemy killed")
		#self.state
		Global.enemy_killed.emit() #
	if self.is_in_group("player"):
		Global.game_over.emit()
	
