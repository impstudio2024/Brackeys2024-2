extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.angryGM.connect(angryGM)
	Global.idleGM.connect(idleGM)

func angryGM():
	play("angry")
func idleGM():
	play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
