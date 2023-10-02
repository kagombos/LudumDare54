extends Node2D

class FadingLine:
	var opacity = 1
	var color = Color(255, 255, 255)
	var line: Line2D
	var fadingStars = []
	
	func _init(line, fadingStars, color):
		self.line = line
		self.fadingStars = fadingStars
		self.color = color

@export var lineColor = Color(1,1,1,1)
@export var lineWidth = 20
@export var mouseButton = 1

var drawing = false
var line
var stars = []
var fadingLines = []
var nextColor

var star_prefab = preload("res://Drawing/constellation_point.tscn")

signal LineDrawn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var size = fadingLines.size()
	if fadingLines.size():
		for fadingLine in fadingLines:
			fadingLine.opacity = fadingLine.opacity - 0.05
			for fadingStar in fadingLine.fadingStars:
				fadingStar.modulate = Color(
					fadingLine.color.r, 
					fadingLine.color.g, 
					fadingLine.color.b, 
					fadingStar.modulate.a - 0.05
				)
		var deadLines = fadingLines.filter(func(line): return line.opacity <= 0)
		for deadLine in deadLines:
			deadLine.fadingStars.map(func(star): star.queue_free())
		fadingLines = fadingLines.filter(func(line): return line.opacity > 0)
		self.queue_redraw()

func _input(event):
	if event is InputEventMouseButton and event.button_index == mouseButton:
		drawing = event.pressed
		if drawing:
			line = Line2D.new()
			line.add_point(event.position)
			stars.push_back(add_star(event.position))
		else:
			# end drawing, create path
			LineDrawn.emit(line.points)
			fadingLines.append(FadingLine.new(line.duplicate(), stars, nextColor))
			print(fadingLines.back().color)
			line.clear_points()
			stars = []
			self.queue_redraw()
	if event is InputEventMouseMotion and drawing and event.position.distance_to(line.points[-1]) > 60:
		line.add_point(event.position)
		stars.push_back(add_star(event.position))
		if line.points.size() > 30:
			line.remove_point(0)
			stars.pop_front().queue_free()
		self.queue_redraw()

func add_star(pos):
	var star_instance = star_prefab.instantiate()
	star_instance.position = pos
	add_child(star_instance)
	return star_instance

func _draw():
	if line and line.points.size() > 2:
		draw_polyline(line.points, lineColor, lineWidth)
	for fadingLine in fadingLines:
		if fadingLine.line.points.size() > 2:
			draw_polyline(
				fadingLine.line.points, 
				Color(fadingLine.color.r, fadingLine.color.g, fadingLine.color.b, fadingLine.opacity), 
				lineWidth
			)
			print(fadingLine.color)

func _on_object_detector_object_detected(detectedValue):
	if ElementUtils.DigitToElementMap.has(detectedValue):
		nextColor = ElementUtils.ElementToColor[ElementUtils.DigitToElementMap[detectedValue]]
	else:
		print(line)
		nextColor = lineColor
	print(nextColor)
	pass # Replace with function body.
