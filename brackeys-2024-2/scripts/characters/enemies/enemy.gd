extends Character
class_name Enemy

var initial_pos: Vector2;
var permanently_angry: bool = false
 
@export var dmg = 1

@onready var statemachine: StateMachine = $StateMachine


func _ready() -> void:
	add_to_group("enemies")
	initial_pos = position
	Global.enemy_added.emit(self)
	health_changed.connect(isdead)
	super()
	

# Move the enemy character up 1 unit when the `er has moved
func on_enemy_turn(player: Player):
	if statemachine.state.name != "DeadState":
		await statemachine.state.move(player, self)

func isdead(health: int):
	if not health <= 0: return
	if not statemachine.state.name != "DeadState": return
	var dict: Dictionary = { "enemy": self }
	statemachine._transition_to_next_state("DeadState", dict)


func respawn():
	if statemachine.state.name == "DeadState":
		statemachine._transition_to_next_state("WanderState")

func attack(player: Player, move_direction: Vector2i):
	player.health -= dmg
