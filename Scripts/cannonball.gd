extends CharacterBody2D

var dir: int
var speed: float
var pos: Vector2
func _ready():
	#self.position = Vector2.ZERO
	pass
	
func _process(delta: float) -> void:
	velocity = Vector2(dir*speed, 0)
	move_and_slide()


func _on_timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		area.get_parent().player_killed_func()
	pass # Replace with function body.
