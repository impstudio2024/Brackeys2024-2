extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.entities = $Entities
	Global.map = $Floor
	Global.walls = $Walls
	Global.holes = $Holes
