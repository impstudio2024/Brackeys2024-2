extends Character

var turn_active: bool = true

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
		turn_active = false
		print(move(movement))
		Global.character_moved.emit() # Signal Global after character moves so the signal can be connected to enemies
		print("Character moved!")  # Print a string to confirm that the character moved (FOR DEBUGGING)
