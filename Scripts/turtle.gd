extends CharacterBody2D
@export var location1: Vector2
@export var location2: Vector2
@export var speed: float
var current_target_position: Vector2
var moving;
var alive = true

func _ready() -> void:
	current_target_position = location1
	moving = true
func _physics_process(delta: float) -> void:
	
	if moving:
		self.global_position = self.global_position.move_toward(current_target_position, delta*speed)
	if self.global_position == current_target_position:
		if current_target_position == location1: current_target_position = location2
		elif current_target_position == location2: current_target_position = location1
		

	#move_and_slide()
func _on_killer_area_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player" and alive:
		print("player killed")
		
		var player = area.get_parent()
		player.player_killed_func()
			
	pass # Replace with function body.


func _on_dying_area_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		var player = area.get_parent()
		if !player.player_killed:
			alive = false
			print("killed by player")
			player.velocity.y = player.jump_power
			player.touching_ground = false
			location1 = Vector2(self.global_position.x, self.global_position.y - 10.0)
			location2 = Vector2(self.global_position.x, self.global_position.y + 500)
			speed = 100
			current_target_position = location1
			await get_tree().create_timer(3.0).timeout
			self.queue_free()
	pass # Replace with function body.
