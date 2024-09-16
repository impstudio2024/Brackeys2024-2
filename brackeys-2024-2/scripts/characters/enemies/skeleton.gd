extends Enemy
class_name Skeleton

var type: String = 'Skeleton'

func play_move_sound():
	$sfx_player.play_sound('res://Assets/Sound/Characters/enemies/skelleton/walk 1.mp3')

func attack(player: Player, move_direction: Vector2i):
	super(player, move_direction)
	print("moved from " + str(map_position))
	move_and_jump_over(-move_direction)
	print('moved to ' + str(map_position))
	$sfx_player.play_sound('res://Assets/Sound/Characters/enemies/skelleton/slash hit.mp3')
	