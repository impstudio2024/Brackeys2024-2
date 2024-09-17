extends Character
class_name Player

@export var dmg: int = 1

var turn_active: bool = true
var cleared: bool


@onready var current_weapon : GameplayWeapon = $Weapon/Fists

@onready var previous_direction : Vector2i = Vector2i.UP

func _ready() -> void:
	cleared = false
	health_changed.connect(_on_health_changed.bind())
	Global.weapon_picked_up.connect(change_weapon)
	Global.enemy_moved.connect(func(): turn_active = true)
	Global.player_health_changed.connect(_on_health_changed)
	add_to_group("player")
	return super._ready()


func _process(_delta: float) -> void:
	if not turn_active: return


	var movement: Vector2i = Vector2i.ZERO

	if Input.is_action_pressed("move_down"): movement.y = 1
	elif Input.is_action_pressed('move_up'): movement.y = -1

	if Input.is_action_pressed("move_left"):
		movement.x = -1
		$WhiteSquare.flip_h = true
	elif Input.is_action_pressed('move_right'):
		movement.x = 1
		$WhiteSquare.flip_h = false

	if Input.is_action_pressed('move_down') and Input.is_action_pressed('move_up'): movement.y = 0
	if Input.is_action_pressed('move_left') and Input.is_action_pressed('move_right'): movement.x = 0

	if movement.length_squared() > 1:
		movement = Vector2i.ZERO
	if movement != Vector2i.ZERO:
		turn_active = false

		var should_move: bool = true

		if movement == previous_direction:
			var tile_map_layer: TileMapLayer = $Weapon.get_child(0).get_child(0)
			for child in tile_map_layer.get_children():
				if not child.currentOpponent: continue
				child.currentOpponent.damage_by(dmg)
				should_move = false
			match $Weapon.get_child(0).name:
				'Broadsword':
					$sfx_player.play_sound('res://assets/sound/characters/weapons/broadsword/broadsword_hit.mp3')
				'Bow':
					$sfx_player.play_sound('res://assets/sound/characters/weapons/bow/bow_rope.mp3')
				'Spear':
					$sfx_player.play_sound('res://assets/sound/characters/weapons/spear/spear_hit.mp3')
		previous_direction = movement

		if should_move:
			$Weapon.get_child(0).move(previous_direction)
			$sfx_player.play_sound('res://assets/sound/characters/protagonist/protagonist_walk.mp3')
			await move(movement)

		Global.player_moved.emit(self)


	match Global.specials.get_cell_source_id(map_position):
		Global.SpecialTileTypes.EXIT:
			if not cleared:
				Global.levelClear.emit()
				cleared = true


func change_weapon(weapon: GameplayWeapon, pickup: Pickup):
	#0 -> no weapon | 1 -> broadsword | 2 -> spear | 3 -> bow
	var oldWeapon = $Weapon.get_child(0)
	#weapon.position = oldWeapon.position
	$Weapon.remove_child(oldWeapon)
	weapon.position = oldWeapon.position
	oldWeapon.queue_free()
	$Weapon.add_child(weapon)
	weapon.move(previous_direction)

	pickup.queue_free()
	damage = weapon.damage
	#print(weapon.name + " picked up!")

	weapon.position = oldWeapon.position
	weapon.call_deferred('move', previous_direction)


func _on_health_changed(_current_health: int):
	$sfx_player.play_sound('res://assets/sound/characters/protagonist/protagonist_hurt.mp3')

	if health <= 0:
		Global.game_over.emit()
		# print('gameover')

func turnActive():
	turn_active = true
