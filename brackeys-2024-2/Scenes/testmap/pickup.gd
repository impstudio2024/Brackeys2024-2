class_name Pickup

extends Area2D
@export var renewable: bool = false
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if collision_shape_2d.disabled == false:
			print("Body entered!")
			visible = false
			collision_shape_2d.disabled = true	
			# Initialize timer for respawning the item (optional)
			if renewable:
				timer.start()


func _on_timer_timeout() -> void:
	visible = true
	collision_shape_2d.disabled = false
