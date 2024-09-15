extends Node

var hearts = 6
var maxhearts = 6

@onready var empty_hearts: TextureRect = $EmptyHearts
@onready var full_hearts: TextureRect = $FullHearts

func _ready():
	Global.player_health_changed.connect(change_texture)
	empty_hearts.size.x = maxhearts * 18
	full_hearts.size.x = hearts * 18
	
func change_texture(value):
	hearts = value
	if hearts > 0:
		full_hearts.size.x = hearts * 18
	elif hearts == 0:
		full_hearts.queue_free()
	
