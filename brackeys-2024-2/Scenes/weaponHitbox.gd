extends Area2D
var wielder : Character
var currentOpponent : Character

func _ready():
	Global.connect("attack", damage_opponent)

func _on_body_entered(body: Node2D) -> void:
	#if wielder is Character:
		if body is Enemy:
			print("there we go, enemy at " + name)
			currentOpponent = body

func damage_opponent(target: Character, damage: int):
	if overlaps_body(target):
		print("Attack launched on: ", target.name, " for ", damage, " damage")
		target.damage_by(damage)

func _on_body_exited(body: Node2D) -> void:
	print("bye bye from " + name)
	currentOpponent = null
	
