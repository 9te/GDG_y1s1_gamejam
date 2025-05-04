extends CharacterBody2D
@export var location1: Vector2
@export var location2: Vector2
@export var speed: float
var current_target_position: Vector2
var moving;
var alive = true
var await_movement = false
@onready var ani: AnimatedSprite2D = $ani

func _ready() -> void:
	current_target_position = location1
	moving = true
func _physics_process(delta: float) -> void:
	
	if moving:
		self.global_position = self.global_position.move_toward(current_target_position, delta*speed)
	if self.global_position == current_target_position and !await_movement:
		await_movement = true
		ani.play("idle")
		await get_tree().create_timer(2.0).timeout
		ani.play("run")
		if current_target_position == location1: current_target_position = location2
		elif current_target_position == location2: current_target_position = location1
		await_movement = false

	#move_and_slide()
func _on_killer_area_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player" and alive:
		print("player killed")
		
		var player = area.get_parent()
		player.player_killed_func()
			
	pass # Replace with function body.
