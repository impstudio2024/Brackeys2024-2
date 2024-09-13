extends Button

# Create a list of credits to be displayed
var credits = [
	
	["A Game by ImpStudio"],
	
	["naxiv"],
	
	["Dex"],
	
	["Malario"],
	
	["Ikkiren"],
	
	["kierownik"],
	
	["Kyoresu"],
	
	["Mapet"],
	
	["JackleBox"],
	
	["sx0rm"],
	
	["WeBack"],
	
	["careware"],
	
	["Special thanks to"],
		["Brackeys"],
		["Godot"],
	]


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	
