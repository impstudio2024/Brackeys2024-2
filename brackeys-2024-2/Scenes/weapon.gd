
class_name Weapon
extends Pickup

enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var type: Weapons

@export var damage: int
#@export var radius: int

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	
	if body.has_meta("type"):
		if collision_shape_2d.disabled == false:
			print(Weapons.keys()[type] + " picked up!")
			
			
			#call the method for changing the player's weapon sprite
			body.display_weapon(type)
			
			#visible = false
			#collision_shape_2d.disabled = true	
			## Initialize timer for respawning the item (optional)
			#if expirable:
				#timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
