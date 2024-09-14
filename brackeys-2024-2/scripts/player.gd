extends Character
class_name Player

var turn_active: bool = true


func _ready() -> void:	
	Global.connect("weapon_picked_up", change_weapon)
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
		$Weapon.get_child(0).move(movement)
		await move(movement)
		#print("Character moved!")  # Print a string to confirm that the character moved (FOR DEBUGGING)
		Global.player_moved.emit(self) # Signal Global after character moves so the signal can be connected to enemies
	
func change_weapon(weapon: GameplayWeapon, pickup: Pickup):
	#0 -> no weapon | 1 -> broadsword | 2 -> spear | 3 -> bow
	var oldWeapon = $Weapon.get_child(0)
	print(oldWeapon)
	$Weapon.remove_child(oldWeapon)
	oldWeapon.queue_free()
	$Weapon.add_child(weapon)
	#print(weapon.name + " picked up!")
	weapon.position = oldWeapon.position
	
	
func turnActive():

	turn_active = true
