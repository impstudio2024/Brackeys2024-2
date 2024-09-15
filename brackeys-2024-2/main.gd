extends Node2D
@export var transitionScene : PackedScene
var nextScene :PackedScene
var currentTransitionType:String

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.


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
	var sceneInstance = nextScene.instantiate()
	var currentScene = $CanvasGroup/SceneContainer.get_child(0)
	print(currentScene)
	$CanvasGroup/SceneContainer.remove_child(currentScene)
	currentScene.queue_free()
	$CanvasGroup/SceneContainer.add_child(sceneInstance)
	await get_tree().create_timer(2).timeout 
	$CanvasGroup2/ColorRect/AnimationPlayer.play(currentTransitionType+"_out")
