extends Node
@export var introScene: PackedScene
@export var mainMenuScene : PackedScene
@export var creditsScene : PackedScene
@export var gameOverScene : PackedScene
@export var level1Scene : PackedScene
@export var level2Scene : PackedScene
@export var level3Scene : PackedScene
@export var level4Scene : PackedScene
@export var level5Scene : PackedScene
@export var level6Scene : PackedScene
@export var level7Scene : PackedScene
@export var level8Scene : PackedScene
@export var level9Scene : PackedScene
@export var level10Scene : PackedScene


var levels = {}

func _ready() -> void:
	call_deferred("packLevels")

func packLevels():
	levels = {
		1: level1Scene,
		2: level2Scene,
		3: level3Scene,
		4: level4Scene,
		5: level5Scene,
		6: level6Scene,
		7: level7Scene,
		8: level8Scene,
		9: level8Scene,
		10: level8Scene,
		
	}
