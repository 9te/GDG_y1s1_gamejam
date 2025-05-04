extends Node

const SAVE_PATH = "user://savefile.json"

func _ready() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		_load()
	else:
		contents_to_save.level = 1
		_save()
	_load()
	

var contents_to_save: Dictionary = {
	"level": 0
}

func _test():
	pass
	

func _save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()

func _load():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		print("level " + str(save_data.level))
		contents_to_save.level = save_data.level
		
