extends AnimationPlayer
@onready var player_null_ani: AnimatedSprite2D = $"../Player_Null/player_null_ani"
@onready var dialogue_box: Control = $"../DialogueBox"
@onready var dialoguetimer: Timer = $"../DialogueBox/dialoguetimer"
var dialogue_box_skippable
var page = 0
@export var dialogue_text = ["The game has finished", "but why has the exit closed?", "there is only one way to exit this place", "But i dont really have a good feeling about this"] 
@onready var enter_label: Label = $"../DialogueBox/enter"

func type_dialogue(dialogue):
	dialogue_box_skippable = false
	var _label = dialogue_box.get_node("Label")
	for i in range(len(dialogue)):
		dialoguetimer.start()
		await dialoguetimer.timeout
		_label.text = dialogue.substr(0, i+1)
	page += 1
	enter_label.show()
	dialogue_box_skippable = true
	
func _input(event: InputEvent) -> void:
	if dialogue_box_skippable and event.is_action_pressed("Enter"):
		enter_label.hide()
		if page < len(dialogue_text):
			if page == 2:
				player_null_ani.play("idle")
			type_dialogue(dialogue_text[page])
		else:
			dialogue_box.hide()
			player_null_ani.play("run")
			self.play("ending_cutscene")
		


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start_of_cutscene":
		player_null_ani.play("idle")
		self.play("close_exit")
		#player_null_ani.play("idle")
		#dialogue_box.show()
	if anim_name == "close_exit":
		player_null_ani.play("idle_left")
		dialogue_box.show()
		type_dialogue(dialogue_text[page])
	if anim_name == "ending_cutscene":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		
		



	
