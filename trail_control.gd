extends Node2D

@export var lineColor = Color(1,1,1,1)
@export var lineWidth = 20
@export var mouseButton = 1
var drawing = false
var line

class FadingLine:
	var opacity = 1
	var line: Line2D
	
	func _init(line):
		self.line = line

var fadingLines = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if fadingLines.size():
		for fadingLine in fadingLines:
			fadingLine.opacity = fadingLine.opacity - 0.05
		fadingLines = fadingLines.filter(func(line): return line.opacity > 0)
		self.queue_redraw()

func _input(event):
	if event is InputEventMouseButton and event.button_index == mouseButton:
		drawing = event.pressed
		if drawing:
			line = Line2D.new()
			line.add_point(event.position)
		else:
			# end drawing, create path
			fadingLines.append(FadingLine.new(line.duplicate()))
			line.clear_points()
			self.queue_redraw()
	if event is InputEventMouseMotion and drawing and event.position.distance_to(line.points[-1]) > 30:
		line.add_point(event.position)
		if line.points.size() > 30:
			line.remove_point(0)
		self.queue_redraw()
		

func _draw():
	if line and line.points.size() > 2:
		draw_polyline(line.points, lineColor, lineWidth)
	for fadingLine in fadingLines:
		if fadingLine.line.points.size() > 2:
			draw_polyline(fadingLine.line.points, Color(lineColor.r, lineColor.g, lineColor.b, fadingLine.opacity), lineWidth)
