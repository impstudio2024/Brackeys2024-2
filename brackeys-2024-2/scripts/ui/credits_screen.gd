extends Control

@onready var parallax_bg_layer: ParallaxLayer = $ParallaxBackground/ParallaxBGLayer
@onready var parallax_text_layer: ParallaxLayer = $ParallaxBackground/ParallaxTextLayer
@onready var splash_timer: Timer = $SplashTimer
@onready var crawl_timer: Timer = $CrawlTimer
@export var bg_scroll_speed: int = 0
@export var txt_scroll_speed: int = 0
signal next_scene()

func _ready():
	splash_timer.start()

func _on_splash_timer_timeout() -> void:
	bg_scroll_speed = 40
	txt_scroll_speed = 100
	crawl_timer.start(37)
	
func _process(delta: float) -> void:
	parallax_bg_layer.motion_offset.y -= bg_scroll_speed * delta
	parallax_text_layer.motion_offset.y -= txt_scroll_speed * delta
	
func _on_crawl_timer_timeout() -> void:
	Global.backMenu.emit()
