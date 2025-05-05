extends AudioStreamPlayer2D
const STARTING_LOOP = preload("res://Music/starting_loop.wav")
var fade_out_start
@onready var ani: AnimationPlayer = $ani

#func _process(delta: float) -> void:
	#if get_tree().current_scene.name != "Cut_Scene" and get_tree().current_scene.name != "main_menu":
		#if !fade_out_start:
			#fade_out_start = true
			#ani.play("fade_out")

func fade_out_audio():
	ani.play("fade_out")
	#print(get_tree().current_scene.name)
