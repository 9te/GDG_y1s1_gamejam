extends Node

const SAVE_PATH = "user://savefile.json"


static func _save(lvl):
	var contents_to_save: Dictionary = {
		"level": lvl
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(contents_to_save.duplicate())
	file.close()
