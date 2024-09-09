extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):

	#Get the input direction: -1 0 1
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	
	#Apply movement
	if Input.is_action_just_pressed("move_up"):
		position.y -= 10
		
	if Input.is_action_just_pressed("move_down"):
		position.y += 10
		
	if Input.is_action_just_pressed("move_right"):
		position.x += 10
		
	if Input.is_action_just_pressed("move_left"):
		position.x -= 10

	move_and_slide()
