extends Node2D
@export var transitionScene : PackedScene
var gameplay = false
var nextScene :PackedScene
var currentTransitionType:String
var currentLevel = 1
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Global.playGame.connect(playGame)
	Global.seeCredits.connect(seeCredits)
	Global.backMenu.connect(backMenu)
	Global.startBGM.connect(startBGM)
	Global.game_over.connect(game_over)
	Global.levelClear.connect(levelClear)
	Global.retry.connect(retry)

func retry():
	gameplay = true
	transition(SceneRepository.levels[currentLevel],"Dots")
func game_over():
	transition(SceneRepository.gameOverScene,"Dots")
	gameplay = false
func startBGM():
	$BgmPlayer.play()
func playGame():
	$BgmPlayer.starting_bgm()
	transition(SceneRepository.levels[currentLevel],"Dots")
	gameplay = true
func levelClear():
	currentLevel+=1
	transition(SceneRepository.levels[currentLevel],"Dots")
func backMenu():
	transition(SceneRepository.mainMenuScene,"Dots")
	gameplay = false

func seeCredits():
	transition(SceneRepository.creditsScene,"Dots")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func transition(scene,type):
	currentTransitionType = type
	nextScene = scene
	$CanvasGroup2/ColorRect/AnimationPlayer.play(currentTransitionType+"_in")

func _on_intro_finished() -> void:
	transition(SceneRepository.mainMenuScene,"Dots")

func _on_color_rect_transition_in() -> void:
	if gameplay:
		$Camera2D.anchor_mode = $Camera2D.ANCHOR_MODE_DRAG_CENTER
	else:
		$Camera2D.anchor_mode = $Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	if gameplay:
		if $BgmPlayer.playing:
			$BgmPlayer._on_idle_signal()
		else:
			$BgmPlayer.play()
	else:
		$BgmPlayer.stop()
	if nextScene in SceneRepository.levels.values():
		Global.reset_spawners()
	var sceneInstance = nextScene.instantiate()
	var currentScene = $CanvasGroup/SceneContainer.get_child(0)

	$CanvasGroup/SceneContainer.remove_child(currentScene)
	currentScene.queue_free()
	$CanvasGroup/SceneContainer.add_child(sceneInstance)
	await get_tree().create_timer(2).timeout

	$CanvasGroup2/ColorRect/AnimationPlayer.play(currentTransitionType+"_out")
