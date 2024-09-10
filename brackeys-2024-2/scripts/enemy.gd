extends Character

func _ready() -> void:
	Global.connect("character_moved",onPlayerMove) # Connect character_moved signal so that enemies will move after the player has moved

