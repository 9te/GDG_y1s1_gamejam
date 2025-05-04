extends Node2D
@export var current_lvl: int
@onready var cpu_load_bar: ProgressBar = $HUD/UI/CPU_Load
var cpu_load_value = 20
var glitching_rn
@onready var player: CharacterBody2D = $Player
@export var cam_shake_amount: float
@onready var cam: Camera2D = $Player/Camera2D

@onready var time_till_unglitch: Timer = $Time_Till_Unglitch
@onready var effect_shader: ColorRect = $Effect_Shader
@onready var transition: AnimatedSprite2D = $HUD/UI/transition
var rng = RandomNumberGenerator.new()
var lvl_finished = false
#func cut_scene():
@onready var saver: Node2D = $Saver

func next_lvl():
	lvl_finished = true
	$next_lvl_timer.start()
	await $next_lvl_timer.timeout
	print("doneeeeeeeeee")
	transition.show()
	transition.play("transition_out")
	await transition.animation_finished
	saver._save(current_lvl + 1)
	get_tree().change_scene_to_file("res://Scenes/lvl_" + str(current_lvl + 1) + ".tscn")
	
	

func player_dead():
	$player_dead.start()
	await $player_dead.timeout
	transition.show()
	transition.play("transition_out")
	await transition.animation_finished
	
	get_tree().change_scene_to_file("res://Scenes/"+ get_tree().get_current_scene().name + ".tscn")

func Time_To_UnCrash() -> void:
	effect_shader.hide()
	player.Player_Unglitched()
	get_tree().paused = false
	cam.offset = Vector2.ZERO


func Time_To_Crash() -> void:
	if !player.player_killed and !lvl_finished:
		effect_shader.show()
		time_till_unglitch.start()
		#get_tree().paused = true
		#player.paused = true
		player.Player_Glitched()
		
		cam.offset = Vector2(rng.randf_range(-cam_shake_amount, cam_shake_amount), rng.randf_range(-cam_shake_amount, cam_shake_amount))
		cpu_load_value += 10
		if cpu_load_value >= 100:
			player.player_killed_func()
		pass # Replace with function body.


func CPU_Load_Variability_Timer() -> void:
	var new_cpu_load_value = cpu_load_value
	new_cpu_load_value += int(RandomNumberGenerator.new().randf_range(-2, 2))
	cpu_load_bar.value = new_cpu_load_value
	pass # Replace with function body.
