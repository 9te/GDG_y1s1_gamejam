extends Node2D
const cannonball = preload("res://Objects/cannonball.tscn")

const CANNON_R = preload("res://Art/cannonR.png")
const CANNON_L = preload("res://Art/cannonL.png")

func _on_timer_timeout() -> void:
	var instance1 = cannonball.instantiate()
	instance1.dir = -1
	instance1.speed = 100
	instance1.get_node("Sprite2D").texture = CANNON_L
	add_child(instance1)
	var instance2 = cannonball.instantiate()
	instance2.dir = 1
	instance2.speed = 100
	instance2.get_node("Sprite2D").texture = CANNON_R
	add_child(instance2)
	pass # Replace with function body.
