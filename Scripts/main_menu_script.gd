extends Node2D
var allow_game_play = false
@onready var transition: AnimatedSprite2D = $transition

func _on_timer_timeout() -> void:
	$play_button.show()
	allow_game_play = true
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Enter") and allow_game_play:
		transition.show()
		transition.play("transition_out")
		await transition.animation_finished
		print("how'dys")
		get_tree().change_scene_to_file("res://Scenes/lvl_1.tscn")
		
		
