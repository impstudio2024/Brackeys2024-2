extends Node
@export var introScene: PackedScene
@export var mainMenuScene : PackedScene
@export var creditsScene : PackedScene
@export var gameOverScene : PackedScene
@export var level1Scene : PackedScene
@export var level2Scene : PackedScene
@export var level3Scene : PackedScene
@export var level4Scene : PackedScene


var levels = {}

func _ready() -> void:
	call_deferred("packLevels")

func packLevels():
	levels = {
		1: level1Scene,
		2: level2Scene,
		3: level3Scene,
		4: level4Scene
	}
