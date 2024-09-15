extends Enemy
class_name Skeleton

func attack(player: Player, move_direction: Vector2i):
	super(player, move_direction)
	print("moved from " + str(map_position))
	move_and_jump_over(-move_direction)
	print('moved to ' + str(map_position))
	
