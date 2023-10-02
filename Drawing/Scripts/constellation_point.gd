extends Sprite2D

var time = 0
var amp = 0.2
var freq = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	scale = Vector2(1 + amp * sin(freq * time), 1 + amp * sin(freq * time))
