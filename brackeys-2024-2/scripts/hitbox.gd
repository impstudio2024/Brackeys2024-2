extends Area2D

#@onready var hitboxes = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func check_for_enemies() -> Array[Enemy]:
	var enemies_found : Array[Enemy]
	var enemy : Enemy
	#for hitbox in hitboxes.get_:
		#if hitbox.has_overlapping_areas():
			#for area in hitbox.get_overlapping_areas():
				#print("enemy spotted")
				#enemies_found.append(area.get_parent())
			
	
	return enemies_found

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("enemy body spotted")
	pass # Replace with function body.


func _on_area_entered(area):
	print("enemy area spotted")
	pass # Replace with function body.
