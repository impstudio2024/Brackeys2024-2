extends Character
class_name Player

var turn_active: bool = true

@onready var debug_weapon_displayed = $DEBUG_WeaponDisplayed
enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var current_weapon : Weapons

func _ready() -> void:	
	add_to_group("player")
	display_weapon(Weapons.NONE)
	return super._ready()

func _process(_delta: float) -> void:
	# placeholder
	if Input.is_action_just_pressed("space"):

		turn_active = true
		
	if not turn_active: return

	var movement: Vector2i
	if Input.is_action_pressed("move_down"): movement.y = 1
	elif Input.is_action_pressed('move_up'): movement.y = -1

	if Input.is_action_pressed("move_left"): movement.x = -1
	elif Input.is_action_pressed('move_right'): movement.x = 1

	if Input.is_action_pressed('move_down') and Input.is_action_pressed('move_up'): movement.y = 0
	if Input.is_action_pressed('move_left') and Input.is_action_pressed('move_right'): movement.x = 0

	if movement.length_squared() > 1:
		movement = Vector2i.ZERO

	if movement != Vector2i.ZERO:
		Global.character_moved.emit() # Signal Global after character moves so the signal can be connected to enemies
		turn_active = false
		print(await move(movement))
		print("Character moved!")  # Print a string to confirm that the character moved (FOR DEBUGGING)
	
func display_weapon(weapon: Weapons):
	#0 -> no weapon | 1 -> broadsword | 2 -> spear | 3 -> bow
	debug_weapon_displayed.set_frame_and_progress(weapon, 0.0)
	
func turnActive():

	turn_active = true
