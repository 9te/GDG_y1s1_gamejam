extends CharacterBody2D
var shell_mode = false
@export var speed: float
@export var extra_speed: float
var dir_right = false
var dead = false
var current_target_position
var location1
var location2
@onready var ani: AnimatedSprite2D = $ani
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	if dir_right:
		if !shell_mode: ani.play("idle_R")
		velocity.x = speed
	else:
		if !shell_mode: ani.play("idle_L")
		velocity.x = -speed
	
	if !dead: move_and_slide()
	if dead:
		self.global_position = self.global_position.move_toward(current_target_position, delta*speed)
		if self.global_position == current_target_position:
			if current_target_position == location1: current_target_position = location2
			elif current_target_position == location2: current_target_position = location1


func killer_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		print("player killed")
		
		var player = area.get_parent()
		player.player_killed_func()


func dying_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player" and !shell_mode:
		shell_mode = true
		var player = area.get_parent()
		player.velocity.y = player.jump_power
		player.touching_ground = false
		speed = extra_speed
		ani.play("shell")
	elif area.get_parent().name == "Player" and shell_mode:
		var player = area.get_parent()
		if !player.player_killed:
			dead = true
			player.velocity.y = player.jump_power
			player.touching_ground = false
			location1 = Vector2(self.global_position.x, self.global_position.y - 10.0)
			location2 = Vector2(self.global_position.x, self.global_position.y + 500)
			collision_shape_2d.disabled = true
			current_target_position = location1
			await get_tree().create_timer(3.0).timeout
			self.queue_free()
	pass # Replace with function body.


func _on_left_detector_body_entered(body: Node2D) -> void:
	dir_right = true
	pass # Replace with function body.


func _on_right_detector_body_entered(body: Node2D) -> void:
	dir_right = false
	pass # Replace with function body.
