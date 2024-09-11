extends Character

var turn_active: bool = true

func _process(_delta: float) -> void:
    # placeholder
    if Input.is_action_just_pressed("space"):
        turn_active = true


    if not turn_active: return

    var movement: Vector2i
    if Input.is_action_pressed("down"): movement.y = 1
    elif Input.is_action_pressed('up'): movement.y = -1

    if Input.is_action_pressed("left"): movement.x = -1
    elif Input.is_action_pressed('right'): movement.x = 1

    if Input.is_action_pressed('down') and Input.is_action_pressed('up'): movement.y = 0
    if Input.is_action_pressed('left') and Input.is_action_pressed('right'): movement.x = 0

    if movement.length_squared() > 1:
        movement = Vector2i.ZERO

    if movement != Vector2i.ZERO:
        turn_active = false
        print(move(movement))
