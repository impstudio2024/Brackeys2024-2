extends Area2D
var wielder : Character
var currentOpponent : Character


func _on_body_entered(body: Node2D) -> void:
	#if wielder is Character:
		if body is Enemy:
			print("there we go, enemy at " + name)
			currentOpponent = body


func _on_body_exited(body: Node2D) -> void:
	print("bye bye from " + name)
	currentOpponent = null
	
