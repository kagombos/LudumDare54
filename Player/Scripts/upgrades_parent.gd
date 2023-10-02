extends Node2D

var spawning = true

func _ready():
	scale = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawning:
		scale += Vector2.ONE * delta
		rotation_degrees += 360 * delta
		if scale.x > 1:
			scale = Vector2.ONE
			rotation_degrees = 0
			spawning = false
