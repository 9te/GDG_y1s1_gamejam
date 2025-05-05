extends Node2D
var allow_game_play = false
@onready var transition: AnimatedSprite2D = $transition
@onready var loader: Node2D = $Loader
var called = false
@onready var audio_listener_2d: AudioListener2D = $AudioListener2D
func _ready() -> void:
	audio_listener_2d.is_current()

func _on_timer_timeout() -> void:
	$play_button.show()
	allow_game_play = true
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if !called and event.is_action_pressed("Enter") and allow_game_play:
		called = true
		GAudio.fade_out_audio()
		transition.show()
		transition.play("transition_out")
		await transition.animation_finished
		
		var lvl_to_go_to = loader.contents_to_save.level
		print(lvl_to_go_to)
		get_tree().change_scene_to_file("res://Scenes/lvl_" + str(lvl_to_go_to) + ".tscn")
		
		
