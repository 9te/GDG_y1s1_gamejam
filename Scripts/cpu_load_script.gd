extends ProgressBar

func _process(delta: float) -> void:
	#self_modulate.a = 1
	if self.value >= 50:
		#self.queue_free()
		self_modulate.r = 255
