extends Button
@export var level_num: int

func _ready() -> void:
	$Label.text = str(level_num)
	
	
