extends Node2D
const cannonball = preload("res://Objects/cannonball.tscn")



func _on_timer_timeout() -> void:
	var instance1 = cannonball.instantiate()
	instance1.dir = -1
	instance1.speed = 100
	add_child(instance1)
	#var instance2 = cannonball.instantiate()
	#instance2.dir = 1
	#instance2.speed = 100
	#add_child(instance2)
	pass # Replace with function body.
