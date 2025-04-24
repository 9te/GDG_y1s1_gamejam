extends AnimationPlayer


func shake_ani():
	play("shake")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shake":
		play("idle")
	pass # Replace with function body.
