extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):

	#Get the input direction: -1 0 1
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	var vertical_direction = Input.get_axis("move_up", "move_down")
	
	#Apply movement
	if horizontal_direction:
		position.x += 1
	else:
		position.x -= 1
		
	if vertical_direction:
		position.y += 1
	else:
		position.y -= 1

	move_and_slide()
