extends Character
class_name Enemy

var initial_pos: Vector2;

func _ready() -> void:
	initial_pos = position
	Global.enemy_added.emit(self)
	super()
	

# Move the enemy character up 1 unit when the player has moved
func on_enemy_turn(player: Player):
	if $StateMachine.state.name != "DeadState":
		await $StateMachine.state.move(player, self)

func dead():
	if $StateMachine.state.name != "DeadState":
		var dict: Dictionary = { "enemy": self }
		$StateMachine._transition_to_next_state("DeadState", dict)


func respawn():
	if $StateMachine.state.name == "DeadState":
		$StateMachine._transition_to_next_state("WanderState")


func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		dead()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		respawn()
