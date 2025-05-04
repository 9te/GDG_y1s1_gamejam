extends StaticBody2D
var player_killed = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player" and !player_killed:
		player_killed = true
		var player = area.get_parent()
		player.player_killed_func()
	pass # Replace with function body.
