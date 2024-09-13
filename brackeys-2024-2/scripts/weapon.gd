class_name Weapon
extends Pickup

enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var type: Weapons

@export var damage: int
@export var durability: int
@export var picked_up : bool

@onready var hitboxes : TileMapLayer = $Hitboxes

var direction : Vector2i = Vector2i.UP
var old_direction : Vector2i = direction
var original_tiles: Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready():
	picked_up = false
	add_to_group("weapons")
	pass # Replace with function body.



func move(relative_movement):
	old_direction = direction
	hitboxes.update_hitbox_positions(direction)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		if collision_shape_2d.disabled == false:
			#call the method for changing the player's weapon sprite (debug) and give the player hitboxes
			Global.weapon_picked_up.emit(self) # Signal Global after weapon is picked up, for changing the player sprite and hitbox
			picked_up = true
				

func disableFists():
	collision_shape_2d.disabled = true
	
