class_name Weapon
extends Pickup

enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var type: Weapons
@export var gameplayWeaponScene :PackedScene
@export var damage: int
@export var durability: int
@export var picked_up : bool

var direction : Vector2i = Vector2i.UP
var old_direction : Vector2i = direction
var original_tiles: Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready():
	picked_up = false
	add_to_group("weapons")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		if collision_shape_2d.disabled == false:
			var gameplayWeapon = gameplayWeaponScene.instantiate()
			#call the method for changing the player's weapon sprite (debug) and give the player hitboxes
			Global.weapon_picked_up.emit(gameplayWeapon,self) # Signal Global after weapon is picked up, for changing the player sprite and hitbox
			picked_up = true
			
