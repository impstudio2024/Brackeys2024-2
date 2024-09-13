extends Character
class_name Enemy

func _ready() -> void:
	add_to_group("enemies")
	Global.enemy_added.emit(self)
	super()
	

# Move the enemy character up 1 unit when the player has moved
func on_enemy_turn(player: Player):
	await $StateMachine.state.move(player, self)
