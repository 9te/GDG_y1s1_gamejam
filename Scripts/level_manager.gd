extends Node2D
@export var current_lvl: int
@onready var cpu_load_bar: ProgressBar = $HUD/UI/CPU_Load
var cpu_load_value = 20
var glitching_rn
@onready var player: CharacterBody2D = $Player
@export var cam_shake_amount: float
@onready var cam: Camera2D = $Player/Camera2D2
@onready var player_dead_timer: Timer = $player_dead

@onready var time_till_unglitch: Timer = $Time_Till_Unglitch
@onready var effect_shader: ColorRect = $HUD/Effect_Shader
@onready var transition: AnimatedSprite2D = $HUD/UI/transition
var rng = RandomNumberGenerator.new()
var lvl_finished = false
#func cut_scene():
@onready var saver: Node2D = $Saver
@onready var saving_label: Label = $HUD/UI/saving_label
@export var player_pos: Vector2
const PLAYER = preload("res://Objects/Player.tscn")
var game_restarted = false
const MAIN = preload("res://Music/main.wav")
const GLITCH = preload("res://Music/glitch.wav")
const HIT_HURT = preload("res://Music/hitHurt.wav")

@onready var audio_extra: AudioStreamPlayer2D = $AudioExtra
@onready var audio_listener_2d: AudioListener2D = $Player/AudioListener2D


func _ready() -> void:
	audio_listener_2d.is_current()
	print(current_lvl)
	if GAudio.volume_db == -20:
		GAudio.stream = MAIN
		GAudio.volume_db = 0
		GAudio.play()
func instantiate_player():
	var player_inst = PLAYER.instantiate()
	player_inst.position = player_pos

func next_lvl():
	lvl_finished = true
	saving_label.show()
	$next_lvl_timer.start()
	await $next_lvl_timer.timeout
	print("doneeeeeeeeee")
	transition.show()
	transition.play("transition_out")
	await transition.animation_finished
	if current_lvl >= 3:
		saver._save(1)
		get_tree().change_scene_to_file("res://Scenes/the_end_scene.tscn")
	else:
		saver._save(current_lvl + 1)
		get_tree().change_scene_to_file("res://Scenes/lvl_" + str(current_lvl + 1) + ".tscn")
	
	

func player_dead():
	#player_dead_timer.start()
	#await player_dead_timer.timeout
	transition.show()
	transition.play("transition_out")
	await transition.animation_finished
	
	#print(current_lvl)
	get_tree().change_scene_to_file("res://Scenes/lvl_"+ str(current_lvl) + ".tscn")

func Time_To_UnCrash() -> void:
	GAudio.stream_paused = false
	AudioExtra.stream = GLITCH
	AudioExtra.play()
	effect_shader.hide()
	player.Player_Unglitched()
	get_tree().paused = false
	cam.offset = Vector2.ZERO


func Time_To_Crash() -> void:
	if !player.player_killed and !lvl_finished:
		GAudio.stream_paused = true
		AudioExtra.stream = GLITCH
		AudioExtra.play()
		effect_shader.show()
		time_till_unglitch.start()
		#get_tree().paused = true
		#player.paused = true
		player.Player_Glitched()
		
		cam.offset = Vector2(rng.randf_range(-cam_shake_amount, cam_shake_amount), rng.randf_range(-cam_shake_amount, cam_shake_amount))
		cpu_load_value += 2
		if cpu_load_value >= 100:
			transition.show()
			transition.play("transition_out")
			AudioExtra.stream = HIT_HURT
			AudioExtra.play()
			await transition.animation_finished
			get_tree().change_scene_to_file("res://Scenes/"+ get_tree().get_current_scene().name + ".tscn")
		pass # Replace with function body.


func CPU_Load_Variability_Timer() -> void:
	var new_cpu_load_value = cpu_load_value
	new_cpu_load_value += int(RandomNumberGenerator.new().randf_range(-2, 2))
	cpu_load_bar.value = new_cpu_load_value
	pass # Replace with function body.


func _on_restart_button_button_down() -> void:
	if !game_restarted:
		AudioExtra.stream = HIT_HURT
		AudioExtra.play()
		game_restarted = true
		transition.show()
		transition.play("transition_out")
		await transition.animation_finished
		get_tree().change_scene_to_file("res://Scenes/"+ get_tree().get_current_scene().name + ".tscn")
	pass # Replace with function body.
