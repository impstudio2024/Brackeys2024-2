extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@onready var weapon_displayed = $WeaponDisplayed
enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var current_weapon : Weapons

func _ready() -> void:	
	set_meta("type","player")
	display_weapon(Weapons.NONE)

func _physics_process(delta):
	#Apply movement
	if Input.is_action_just_pressed("move_up"):
		position.y -= 16
		
	if Input.is_action_just_pressed("move_down"):
		position.y += 16
		
	if Input.is_action_just_pressed("move_right"):
		position.x += 16
		
	if Input.is_action_just_pressed("move_left"):
		position.x -= 16

	move_and_slide()
	
func display_weapon(weapon: Weapons):
	#0 -> no weapon | 1 -> broadsword | 2 -> spear | 3 -> bow
	weapon_displayed.set_frame_and_progress(weapon, 0.0)
	 
	
