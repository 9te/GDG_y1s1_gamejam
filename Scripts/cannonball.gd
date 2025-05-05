extends CharacterBody2D

var dir: int
var speed: float
var pos: Vector2
@onready var explosion: AnimatedSprite2D = $explosion
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	#self.position = Vector2.ZERO
	pass
	
func _process(delta: float) -> void:
	velocity = Vector2(dir*speed, 0)
	move_and_slide()


func _on_timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		area.get_parent().player_killed_func()
	if area.is_in_group("walls"):
		self.queue_free()
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("walls"):
		dir = 0
		sprite_2d.hide()
		explosion.show()
		explosion.play("default")
		await explosion.animation_finished
		self.queue_free()
	pass # Replace with function body.
