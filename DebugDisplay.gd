extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var screenSize = get_viewport_rect().size
	position = Vector2(screenSize.x - 75, 75)
	print(position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
