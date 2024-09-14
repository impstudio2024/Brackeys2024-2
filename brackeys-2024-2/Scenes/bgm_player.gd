extends AudioStreamPlayer

var stream_idle: AudioStream = null
var stream_angry: AudioStream = null
var min_vol_value: int = -80
var max_vol_value: int = 0
@export var crossfade_time: float 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("starting_bgm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# This is just for testing purposes. Signals must be connected
	if Input.is_action_just_pressed("ui_accept"):
		print("Received order to angry")
		_on_angry_signal()
	if Input.is_action_just_pressed("down"):
		print("Received order to idle")
		_on_idle_signal()

func starting_bgm():
	stream_idle = stream.get_sync_stream(0)
	stream_angry = stream.get_sync_stream(1)
	stream.set_sync_stream_volume(0, max_vol_value)
	stream.set_sync_stream_volume(1, min_vol_value)


# Func that will be called when receiving the angry signal
func _on_angry_signal():
	crossfade_streams(0, 1, crossfade_time)
func _on_idle_signal():
	crossfade_streams(1, 0, crossfade_time)

func crossfade_streams(fade_out_index: int, fade_in_index: int, duration: float) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.tween_method(
		func(vol): stream.set_sync_stream_volume(fade_out_index, vol),
		stream.get_sync_stream_volume(fade_out_index),
		min_vol_value,
		duration
	)
	
	tween.parallel().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT).tween_method(
		func(vol): stream.set_sync_stream_volume(fade_in_index, vol),
		min_vol_value,
		max_vol_value,
		duration
	)
