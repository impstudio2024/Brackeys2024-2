extends Enemy
class_name DarkKnight

var type: String = 'DarkKnight'

func attack(player: Player, move_direction: Vector2i):
	super(player, move_direction)
	player.move_and_jump_over(move_direction)
	$sfx_player.play_sound('res://Assets/Sound/Characters/enemies/dark knight/Dark knight hit.mp3')

func play_move_sound():
	$sfx_player.play_sound('res://Assets/Sound/Characters/enemies/dark knight/Dark knight steps.mp3')
	
	
