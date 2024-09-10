class_name Weapon
extends Pickup

@onready var weapon_sprite = $WeaponSprite

@export var damage: int
#@export var radius: int

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	
	if collision_shape_2d.disabled == false:
		print("Weapon picked up!")
		
		#call the method for changing the player's weapon sprite
		
		
		#visible = false
		#collision_shape_2d.disabled = true	
		## Initialize timer for respawning the item (optional)
		#if expirable:
			#timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
