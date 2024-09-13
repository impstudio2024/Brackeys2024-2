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
		old_direction = direction
		update_hitbox_positions(direction)
		check_for_enemies()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not picked_up:
		if collision_shape_2d.disabled == false:
			#call the method for changing the player's weapon sprite (debug) and give the player hitboxes
			Global.weapon_picked_up.emit(self) # Signal Global after weapon is picked up, for changing the player sprite and hitbox
			picked_up = true
				
func createOriginalTiles():
	for tile in hitboxes.get_used_cells():
		original_tiles.append(tile)
		hitboxes.erase_cell(tile)
		
		
func check_for_enemies() -> Array[Enemy]:
	var enemies_found : Array[Enemy]
	
	var all_enemies = Global.get_all_enemies()
	
	for hitbox in hitboxes.get_used_cells():
		for enemy in all_enemies:
			#print(enemy.map_position)
			if hitbox == enemy.map_position:
				print ("enemy in attack range")
				enemies_found.append(enemy)
		
	return enemies_found


func update_hitbox_positions(direction:Vector2i):
	var newTiles = find_new_tiles_position(direction)
	for tile in hitboxes.get_used_cells():
		hitboxes.set_cell(tile,-1)
	for newTile in newTiles:
		hitboxes.set_cell(newTile,0,Vector2i(0, 0),1)
	hitboxes.connect_children()

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
