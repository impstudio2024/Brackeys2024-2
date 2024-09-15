extends Character
class_name Player

@export var dmg: int = 1

var turn_active: bool = true
var previous_move: Vector2i = Vector2i.ZERO


@onready var current_weapon : GameplayWeapon = $Weapon/Fists

func _ready() -> void:
	health_changed.connect(_on_health_changed.bind())
	Global.weapon_picked_up.connect(change_weapon)
	Global.enemy_moved.connect(func(): turn_active = true)
	add_to_group("player")
	return super._ready()


func _process(_delta: float) -> void:
	if not turn_active: return

	var movement: Vector2i = Vector2i.ZERO
	
	if Input.is_action_just_released("move_down"): movement.y = 1
	elif Input.is_action_just_released('move_up'): movement.y = -1

	if Input.is_action_just_released("move_left"): movement.x = -1
	elif Input.is_action_just_released('move_right'): movement.x = 1

	if Input.is_action_just_released('move_down') and Input.is_action_just_released('move_up'): movement.y = 0
	if Input.is_action_just_released('move_left') and Input.is_action_just_released('move_right'): movement.x = 0

	if movement.length_squared() > 1:
		movement = Vector2i.ZERO
	if movement != Vector2i.ZERO:
		turn_active = false
		previous_move = movement

		var should_move: bool = true
		$Weapon.get_child(0).move(movement)
		var tile_map_layer: TileMapLayer = $Weapon.get_child(0).get_child(0)
		for child in tile_map_layer.get_children():
			if not child.currentOpponent: continue
			child.currentOpponent.damage_by(dmg)
			should_move = false
		
		if should_move: await move(movement)
		
		Global.player_moved.emit(self)


	match Global.specials.get_cell_source_id(map_position):
		Global.SpecialTileTypes.EXIT:
			print('An exit tile was reached by the player, but the levels are not yet created. If they are done by now add their paths to the level_paths variable of Global and uncomment the line above. Feel free to delete this line. If there are any questions message Malario.')
		

	
func change_weapon(weapon: GameplayWeapon, pickup: Pickup):
	#0 -> no weapon | 1 -> broadsword | 2 -> spear | 3 -> bow
	var oldWeapon = $Weapon.get_child(0)
	print(oldWeapon)
	$Weapon.remove_child(oldWeapon)
	oldWeapon.queue_free()
	$Weapon.add_child(weapon)
	#print(weapon.name + " picked up!")
	weapon.position = oldWeapon.position
	weapon.call_deferred('move', previous_move)
	

func _on_health_changed():
	if health <= 0:
		print('The player died. The death animation needs to be played. Do this in player.gd:9 ')
		Global.game_over.emit()

func turnActive():
	turn_active = true
