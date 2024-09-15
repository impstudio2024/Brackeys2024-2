extends Enemy
class_name DarkKnight

func attack(player: Player, move_direction: Vector2i):
	super(player, move_direction)
	player.move_and_jump_over(move_direction)
