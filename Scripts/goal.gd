extends CharacterBody2D

var lvl_completed = false
var player_current_target_position
var player
var l_area_player = false
var r_area_player = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var player_done: Sprite2D = $player_done





func _physics_process(delta: float) -> void:
	if l_area_player and r_area_player and !lvl_completed:
		lvl_completed = true
		self.get_parent().next_lvl()
		player.player_time_scale = 0
		player.player_input_disabled = true
		#Engine.time_scale = 0
		player.hide()
		player_done.show()
		
		player_done.get_node("AnimationPlayer").play("going_down")
		#collision_shape_2d.disabled = true
		#player.global_position = Vector2(self.global_position.x, self.global_position.y - 16)
		#player_current_target_position = Vector2(player.global_position.x, player.global_position.y + 500)
		
		#player.velocity = Vector2.ZERO
		
		
		#player.global_position.move_toward(player_current_target_position, delta*0.0001)

		




func L_Area(area: Area2D) -> void:
	if area.get_parent().name == "Player": 
		l_area_player = true
		player = area.get_parent()
	
	pass # Replace with function body.


func R_Area(area: Area2D) -> void:
	if area.get_parent().name == "Player": 
		r_area_player = true
		player = area.get_parent()
	pass # Replace with function body.


func R_Area_Exited(area: Area2D) -> void:
	if area.get_parent().name == "Player": r_area_player = false
	pass # Replace with function body.


func L_Area_Exited(area: Area2D) -> void:
	if area.get_parent().name == "Player": l_area_player = false
	pass # Replace with function body.



	pass # Replace with function body.
