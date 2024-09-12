class_name Weapon
extends Pickup

enum Weapons { NONE, BROADSWORD, SPEAR, BOW }
@export var type: Weapons
@export var damage: int
@export var durability: int
@export var picked_up : bool

@onready var hitboxes = $Hitboxes

var direction : Vector2i = Vector2i.UP
var original_tiles: Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready():
	picked_up = false
	add_to_group("weapons")
	call_deferred("createOriginalTiles")
	pass # Replace with function body.

func _process(delta: float) -> void:
	if picked_up:
		if Input.is_action_just_pressed("move_up"):
			direction = Vector2i.UP
		elif Input.is_action_just_pressed("move_left"):
			direction = Vector2i.LEFT
		elif Input.is_action_just_pressed("move_down"):
			direction = Vector2i.DOWN
		elif Input.is_action_just_pressed("move_right"):
			direction = Vector2i.RIGHT
		find_victims(direction)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		if collision_shape_2d.disabled == false:
			#call the method for changing the player's weapon sprite (debug) and give the player hitboxes
			var new_tiles  = find_new_tiles_position(direction)
			Global.weapon_picked_up.emit(self) # Signal Global after weapon is picked up, for changing the player sprite and hitbox
			picked_up = true
				
func createOriginalTiles():
	for tile in hitboxes.get_used_cells():
		original_tiles.append(tile)
		hitboxes.erase_cell(tile)

func find_victims(direction:Vector2i) -> Array:
	var victims = []
	var newTiles = find_new_tiles_position(direction)
	for tile in hitboxes.get_used_cells():
		hitboxes.set_cell(tile,-1)
	for newTile in newTiles:
		hitboxes.set_cell(newTile,0,Vector2i(0, 0),1)
	if not victims.is_empty():
		print("Victim found")
	return victims

func find_new_tiles_position(direction:Vector2i) -> Array[Vector2i]:
	var newTiles :  Array[Vector2i] = []
	for tilePos in original_tiles:
		var newTile = Vector2i.ZERO
		match direction:
			Vector2i.UP:
				newTile = Vector2i(tilePos.y,-tilePos.x)
			Vector2i.LEFT:
				newTile = Vector2i(-tilePos.x, tilePos.y)
			Vector2i.DOWN:
				newTile = Vector2i(-tilePos.y, tilePos.x)
			Vector2i.RIGHT:
				newTile = Vector2i(tilePos.x, tilePos.y)
		newTiles.append(newTile)
	return newTiles
