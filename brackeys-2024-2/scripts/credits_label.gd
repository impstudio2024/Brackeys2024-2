extends Label


# Create a list of credits to be displayed
var credits = [
	"A Game by ImpStudio",
	
	"naxiv",
	
	"Dex",
	
	"Malario",
	
	"Ikkiren",
	
	"kierownik",
	
	"Kyoresu",
	
	"Mapet",
	
	"JackleBox",
	
	"sx0rm",
	
	"WeBack",
	
	"careware",]
	
@export var counter = 0
	
func print_credits() -> void:
	#while counter < credits.size():
		text = credits[counter]
		#counter += 1
		#await 4
 
func _ready() -> void:
	print_credits()
