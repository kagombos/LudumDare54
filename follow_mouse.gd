extends CharacterBody2D

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	var speed = 100
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	var target_position = (mouse_position - position).normalized()
	if self.position.distance_to(mouse_position) < 3:
		move_and_slide()
	pass
