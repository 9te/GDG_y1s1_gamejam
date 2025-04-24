extends Node2D
@onready var cpu_load_bar: ProgressBar = $UI/CPU_Load
var cpu_load_value = 20
var glitching_rn
@onready var player: CharacterBody2D = $Player
@onready var cam: Camera2D = $Camera2D
@onready var time_till_unglitch: Timer = $Time_Till_Unglitch
@onready var effect_shader: ColorRect = $Effect_Shader

#func cut_scene():
	

func Time_To_UnCrash() -> void:
	effect_shader.hide()
	player.Player_Unglitched()
	get_tree().paused = false


func Time_To_Crash() -> void:
	if !player.player_killed:
		effect_shader.show()
		time_till_unglitch.start()
		get_tree().paused = true
		player.Player_Glitched()
			
		cam.get_node("cam_ani").shake_ani()
		cpu_load_value += 10
		
		pass # Replace with function body.


func CPU_Load_Variability_Timer() -> void:
	var new_cpu_load_value = cpu_load_value
	new_cpu_load_value += int(RandomNumberGenerator.new().randf_range(-2, 2))
	cpu_load_bar.value = new_cpu_load_value
	pass # Replace with function body.
