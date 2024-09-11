class_name Weapon
extends Pickup

enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var type: Weapons
@export var uses : int = 1
@export var damage: int
@export var durability: int

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		if collision_shape_2d.disabled == false:
			print(Weapons.keys()[type] + " picked up!")
			uses -= 1
			#call the method for changing the player's weapon sprite
			body.display_weapon(type)
			if uses <= 0:
				queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
