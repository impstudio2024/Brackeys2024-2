extends Control

@onready var parallax_layer: ParallaxLayer = $ParallaxBackground/ParallaxLayer

@export var scroll_speed: int = 50

# First attempt at scrolling parallax layer
func _process(delta: float) -> void:
	parallax_layer.motion_offset.y -= scroll_speed * delta
	
	
