extends Button

# Signal tree to quit on "Flee" button press in Mainmenu
func _on_pressed() -> void:
	get_tree().quit()
