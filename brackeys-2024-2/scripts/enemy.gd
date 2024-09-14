extends Character
class_name Enemy

var initial_pos: Vector2;
var permanently_angry: bool = false

@export var dmg = 1

@onready var statemachine: StateMachine = $StateMachine


func _ready() -> void:
	initial_pos = position
	Global.enemy_added.emit(self)
	super()
	

# Move the enemy character up 1 unit when the player has moved
func on_enemy_turn(player: Player):
	if statemachine.state.name != "DeadState":
		await statemachine.state.move(player, self)

func dead():
	if statemachine.state.name != "DeadState":
		var dict: Dictionary = { "enemy": self }
		statemachine._transition_to_next_state("DeadState", dict)


func respawn():
	if statemachine.state.name == "DeadState":
		statemachine._transition_to_next_state("WanderState")

func attack(player: Player, move_direction: Vector2i):
	player.health -= dmg
