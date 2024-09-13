extends TileMapLayer

#@onready var hitboxes = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("connect_children")
	pass # Replace with function body.
	
func connect_children():
	for child in get_children():
		child.area_entered.connect(_on_area_entered)
		child.body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("enemy body spotted")
	pass # Replace with function body.


func _on_area_entered(area):
	print("enemy area spotted")
	pass # Replace with function body.
