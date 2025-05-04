extends Control
@onready var resume_button: Button = $MarginContainer/VBoxContainer/Resume

func setup_focus():
	resume_button.grab_focus()
func game_quited():
	pass
func game_resumed():
	
	pass
func _ready() -> void:
	pass
	#Save_Game.gameLevel
