extends Node2D
class_name Spawner

var possible_directions: Array[Vector2i] = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN, Vector2i.UP + Vector2i.LEFT, Vector2i.UP + Vector2i.RIGHT, Vector2i.DOWN + Vector2i.LEFT, Vector2i.DOWN + Vector2i.RIGHT]

@export var enemies: Array[PackedScene]
@onready var map_position: Vector2i = Global.specials.local_to_map(position)
@onready var sprite_2d = $Sprite2D

func _ready() -> void:
	sprite_2d.visible = false
	Global.spawners.append(self)

func spawn(chasing_on_spawn: bool) -> void:
	#print('spawning')
	var direction: Vector2i = possible_directions.pick_random()
	#print(direction)
	if find_character_in_cell(map_position + direction): return
	#print('no enemy in the way')
	var enemy: Enemy = enemies.pick_random().instantiate() as Enemy
	enemy.position = Global.entities.map_to_local(map_position + direction)
	Global.entities.add_child(enemy)
	if not chasing_on_spawn: return
	enemy.statemachine.state.finished.emit('ChasingState')
	enemy.permanently_angry = true
	
func find_character_in_cell(cell: Vector2i) -> Character:
	for character in get_tree().get_nodes_in_group('character'):
		if not character.map_position == cell: continue
		return character as Character
	return null
