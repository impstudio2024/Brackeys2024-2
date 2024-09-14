extends Control

@onready var parallax_bg_layer: ParallaxLayer = $ParallaxBackground/ParallaxBGLayer
@onready var parallax_text_layer: ParallaxLayer = $ParallaxBackground/ParallaxTextLayer
@onready var timer: Timer = $Timer

@export var scroll_speed: int = 50

func _ready():
	timer.start()
# First attempt at scrolling parallax layer
func _process(delta: float) -> void:
	parallax_bg_layer.motion_offset.y -= 40 * delta
	parallax_text_layer.motion_offset.y -= scroll_speed * delta
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/mainmenu.tscn")
