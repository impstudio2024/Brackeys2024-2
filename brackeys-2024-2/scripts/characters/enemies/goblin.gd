extends Enemy
class_name Goblin

var type: String = "Goblin"

func play_move_sound():
	$sfx_player.play_sound('res://assets/sound/characters/enemies/goblin/goblin_walk.mp3')
	
func attack(player: Player, move_direction: Vector2i):
	super(player, move_direction)
	$sfx_player.play_sound('res://assets/sound/characters/enemies/goblin/goblin_slash_hit.mp3')
