extends Control

@onready var parallax_bg_layer: ParallaxLayer = $ParallaxBackground/ParallaxBGLayer
@onready var parallax_text_layer: ParallaxLayer = $ParallaxBackground/ParallaxTextLayer

@export var scroll_speed: int = 50

# First attempt at scrolling parallax layer
func _process(delta: float) -> void:
	parallax_bg_layer.motion_offset.y -= 40 * delta
	parallax_text_layer.motion_offset.y -= scroll_speed * delta
	#position.x = 0
	
