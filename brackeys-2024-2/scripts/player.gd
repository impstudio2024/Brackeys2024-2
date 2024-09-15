extends Character
class_name Player

@export var dmg: int = 1

var turn_active: bool = true
var previous_move: Vector2i = Vector2i.ZERO
var cleared = false

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
	
	if Input.is_action_just_released("move_down"): movement.y = 1
	elif Input.is_action_just_released('move_up'): movement.y = -1

	if Input.is_action_just_released("move_left"): 
		movement.x = -1
		$WhiteSquare.flip_h = true
	elif Input.is_action_just_released('move_right'): 
		movement.x = 1
		$WhiteSquare.flip_h = false

	if Input.is_action_just_released('move_down') and Input.is_action_just_released('move_up'): movement.y = 0
	if Input.is_action_just_released('move_left') and Input.is_action_just_released('move_right'): movement.x = 0

	if movement.length_squared() > 1:
		movement = Vector2i.ZERO
	if movement != Vector2i.ZERO:
		turn_active = false
		previous_move = movement

		var should_move: bool = true
		var tile_map_layer: TileMapLayer = $Weapon.get_child(0).get_child(0)
		for child in tile_map_layer.get_children():
			print('currentopponent' + str(child.currentOpponent))
			if not child.currentOpponent: continue
			child.currentOpponent.damage_by(dmg)
			should_move = false
		
		previous_direction = movement
		
		if should_move:
			$Weapon.get_child(0).move(movement)
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
	weapon.call_deferred('move', previous_move)
	

func _on_health_changed(health):
	
	if health <= 0:
		Global.game_over.emit()

func turnActive():
	turn_active = true
