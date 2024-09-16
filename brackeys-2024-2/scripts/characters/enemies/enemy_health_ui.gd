extends Node

@onready var hearts: int = get_parent().health
@onready var maxhearts: int = get_parent().health

@onready var empty_hearts: TextureRect = $EmptyHearts
@onready var full_hearts: TextureRect = $FullHearts

func _ready() -> void:
	get_parent().health_changed.connect(change_texture)
	empty_hearts.size.x = maxhearts * 18
	full_hearts.size.x = hearts * 18
	
func change_texture(value: int) -> void:
	print('health changed to ' + str(value))
	hearts = value
	if hearts > 0:
		full_hearts.size.x = hearts * 18
	elif hearts == 0:
		full_hearts.queue_free()
	
