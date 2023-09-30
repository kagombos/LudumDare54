extends CharacterBody2D

var fireActive = false


# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	position = Vector2.ZERO
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("Fire_Debug"):
		fireActive = true
	else:
		fireActive = false
	if fireActive:
		if scale.x < 1:
			position.x -= 150*delta
			scale += Vector2.ONE*delta
			if scale.x > 1:
				position.x = -150
				scale = Vector2.ONE
	elif scale.x > 0:
		position.x += 150*delta
		scale -= Vector2.ONE*delta
		if scale.x < 0:
			position.x = 0
			scale = Vector2.ZERO
	
