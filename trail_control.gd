extends Node2D

@export var lineColor = Color(1,1,1,1)
@export var lineWidth = 20
@export var mouseButton = 1
var drawing = false
var pathVectors = []
var line

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == mouseButton:
		drawing = event.pressed
		if drawing:
			line = Line2D.new()
			line.add_point(event.position)
			pathVectors.append(event.position)
		else:
			# end drawing, create path
			pathVectors = []
			line.clear_points()
			self.queue_redraw()
	if event is InputEventMouseMotion and drawing:
		line.add_point(event.position)
		self.queue_redraw()
		

func _draw():
	if line:
		draw_polyline(line.points, lineColor, lineWidth)
