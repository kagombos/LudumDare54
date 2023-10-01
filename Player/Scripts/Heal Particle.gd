extends Sprite2D

var spawning = true

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawning:
		scale += Vector2.ONE*delta
		if scale.x >= 0.5:
			spawning = false
	else:
		scale -= Vector2.ONE*delta
		if scale.x <= 0:
			queue_free()
	rotation_degrees += delta*360
