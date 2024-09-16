extends Enemy
class_name Goblin

var type: String = "Goblin"

func play_move_sound():
	$sfx_player.play_sound('res://Assets/Sound/Characters/enemies/goblin/Goblin step.mp3')
	
func attack(player: Player, move_direction: Vector2i):
	super(player, move_direction)
	$sfx_player.play_sound('res://Assets/Sound/Characters/enemies/goblin/slash hit.mp3')
