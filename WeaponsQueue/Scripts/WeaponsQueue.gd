extends Node2D

var DigitToElementMap = {
	11: Element.FIRE #L
}

var ElementDurations = {
	Element.FIRE: 5,
	Element.WATER: 3,
	Element.LIGHT: 3,
	Element.JUNK: 1
}

var activeElement = -1
var activeDuration = 0
var weaponsQueue = []
@export var maxQueueSize = 5

var timer = 0

func push(element):
	if weaponsQueue.size() < 5:
		weaponsQueue.push_back(element)

func pop():
	if weaponsQueue.size() > 0:
		return weaponsQueue.pop_front()

func activateElement():
	activeElement = pop()
	print("activating element ", activeElement)
	activeDuration = ElementDurations[activeElement]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activeDuration > 0:
		activeDuration -= delta
	if activeElement != -1 and activeDuration <= 0:
		activeElement = -1
		if weaponsQueue.size():
			activateElement()

func _on_object_detector_object_detected(detectedValue):
	if DigitToElementMap.has(detectedValue):
		push(DigitToElementMap[detectedValue])
	else:
		push(Element.JUNK)
	if activeElement == -1:
		activateElement()
