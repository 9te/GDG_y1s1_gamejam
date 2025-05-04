extends CharacterBody2D
var dir_x = 0
var facing_right
var running
var touching_ground = false
var player_time_scale = 1
var player_input_disabled
@export var jump_power = -300
@export var movement_speed = 100
@onready var ani: AnimatedSprite2D = $ani
var player_killed = false
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2
@onready var collision_shape_2d_3: CollisionShape2D = $parent_area/CollisionShape2D3

	
func Player_Glitched():
	if !player_killed:
		dir_x = 0
		player_time_scale = 0
		player_input_disabled = true
	
func Player_Unglitched():
	player_time_scale = 1
	

func player_killed_func():
	self.get_parent().player_dead()
	player_input_disabled = true
	velocity = Vector2.ZERO
	player_killed = true

func _physics_process(delta: float) -> void:
	if player_killed:
		collision_shape_2d_2.disabled = true
		collision_shape_2d_3.disabled = true
		var current_target_position = Vector2(self.global_position.x, self.global_position.y - 10)
		self.global_position = self.global_position.move_toward(current_target_position, delta*100)
		if self.global_position == current_target_position:
			current_target_position = Vector2(self.global_position.x, self.global_position.y + 500)
		
	
	delta *= player_time_scale
	
	if touching_ground and player_input_disabled:
			player_input_disabled = false
	if touching_ground and !player_input_disabled:
		if dir_x == 0:
			if facing_right: ani.play("Idle_R")
			else: ani.play("Idle_L")
			running = false
		if dir_x != 0:
			running = true
			if dir_x > 0:
				ani.play("Run_R")
				facing_right = true
			else:
				ani.play("Run_L")
				facing_right = false
	elif !player_input_disabled:
		if dir_x == 0:
			if facing_right: ani.play("Jump_R")
			else: ani.play("Jump_L")
		else:
			running = true
			if dir_x > 0:
				facing_right = true
				ani.play("Jump_R")
			else: 
				facing_right = false
				ani.play("Jump_L")
		
	
	
	
	touching_ground = self.is_on_floor()
	if !player_input_disabled:
		if Input.is_action_just_pressed("Up_Button"):
			if touching_ground:
				velocity.y = jump_power
				touching_ground = false
		if Input.is_action_pressed("Right_Button") and !Input.is_action_pressed("Left_Button"):
			dir_x = 1
		elif Input.is_action_pressed("Left_Button") and !Input.is_action_pressed("Right_Button"):
			dir_x = -1
		else:
			dir_x = 0
		
	
	velocity.x = dir_x * movement_speed
	if player_time_scale == 1:
		move_and_slide()
		_apply_gravity(delta)
	else:
		if !touching_ground:
			if facing_right:
				ani.play("Jump_R")
			else:
				ani.play("Jump_L")
		else:
			if facing_right:
				ani.play("Idle_R")
			else:
				ani.play("Idle_L")
			
			
	
func _apply_gravity(delta: float):
	delta *= player_time_scale
	var grav = get_gravity()
	velocity.y += grav.y
