extends Character

func _ready() -> void:
	Global.connect("character_moved",onPlayerMove) # Connect character_moved signal so that enemies will move after the player has moved
	return super._ready()

# Move the enemy character up 1 unit when the player has moved
func onPlayerMove():
	move(Vector2i.UP)
