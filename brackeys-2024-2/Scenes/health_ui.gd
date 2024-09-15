extends CanvasLayer

var hearts = 3
var maxhearts = 3

@onready var player: Player = $".."
@onready var empty_hearts: TextureRect = $Life/EmptyHearts
@onready var full_hearts: TextureRect = $Life/FullHearts

func _ready():
	if player != null:
		player.health_changed.connect(change_texture)


func change_texture(value):
	hearts = value
	if hearts >= 0:
		if hearts <= maxhearts:
			full_hearts.size.x = hearts * 18
	
