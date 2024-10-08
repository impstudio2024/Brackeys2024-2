extends CharacterBody2D
class_name Character

signal health_changed(current_health:int)

@export var health : int = 6:
	set(value):
		health = value
		# print('health ' + str(health) + ' set on ' + name)
		if self is Player:
			Global.player_health_changed.emit(health)
		health_changed.emit(health)
		#if self is Enemy:
			#Global.enemy_health_changed.emit(self.health)
@onready var damage : int = 5
@onready var animation_player = $AnimationPlayer

var map_position: Vector2i


func _ready() -> void:
	call_deferred("init")

func init():
	add_to_group('character')
	map_position = Global.entities.local_to_map(position)
	Global.entity_positions.set_cell(map_position, 0, Vector2i(0, 0), 1)

func move(relative_movement: Vector2i) -> Character:
	# we are basically not using the tilemmaplayers functionality becasuse it breaks everything. for explanation message @Malario

	var character_on_destination: Character = find_character_in_cell(map_position + relative_movement)
	if character_on_destination: return character_on_destination

	if Global.walls.get_cell_tile_data(map_position + relative_movement): return null

	Global.entity_positions.erase_cell(map_position)
	map_position = map_position + relative_movement
	Global.entity_positions.set_cell(map_position, 0, Vector2i(0, 0), 1)

	# move the character
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(self, "position", Global.entities.map_to_local(map_position), 0.25)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.play()
	await tween.finished

	# when moving the map position will also need to be updated

	if Global.holes.get_cell_tile_data(map_position) and not is_in_group('player'):
		queue_free()
	elif Global.holes.get_cell_tile_data(map_position) and is_in_group('player'):
		$sfx_player.play_sound('res://assets/sound/characters/protagonist/protagonist_jump.mp3')
		move(relative_movement)

	return null

func move_and_jump_over(direction: Vector2i):
	var original_direction: Vector2i = direction
	while find_character_in_cell(direction + map_position):
		direction += original_direction
	move(direction)

func find_character_in_cell(cell: Vector2i) -> Character:
	if Global.entity_positions.get_cell_source_id(cell) == -1: return null
	for character in get_tree().get_nodes_in_group('character'):
		if not character.map_position == cell: continue
		return character as Character
	return null

func damage_by(_damage: int):
	animation_player.play("hurt")
	health -= _damage


	#TODO: play animation, maybe a simple red color modulation for a few frames
	if health <= 0:
		send_to_the_backrooms()

func dead()	:
	pass

func send_to_the_backrooms():
	if self.is_in_group("enemies"):
		# print("enemy killed")
		#self.state
		Global.enemy_killed.emit()
		var enemy = self as Enemy
		enemy.statemachine.changeState.emit('DeadState')
	if self.is_in_group("player"):
		Global.game_over.emit()

func play_move_sound():
	pass
