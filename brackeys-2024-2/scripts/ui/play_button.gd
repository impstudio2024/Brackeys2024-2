extends TextureButton


func _on_pressed() -> void:
	Global.playGame.emit()
