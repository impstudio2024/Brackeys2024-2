extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var weapon_displayed = $WeaponDisplayed

func _physics_process(delta):

	#Get the input direction: -1 0 1
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	
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
	
func display_weapon(sprite: AnimatedSprite2D):
	weapon_displayed = sprite 
	
