extends AnimatedSprite2D
var trap_status
@onready var area_collider: CollisionShape2D = $Area2D/area_collider


func turn_on_area():
	area_collider.disabled = false
func turn_off_area():
	area_collider.disabled = true
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		area.get_parent().player_killed_func()


func _on_timer_timeout() -> void:
	if !trap_status:
		turn_on_area()
		self.play("ShowUp")
		trap_status = true
	elif trap_status:
		turn_off_area()
		self.play("ShowDown")
		trap_status = false
	
