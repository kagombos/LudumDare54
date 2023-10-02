extends Node2D

var ElementDurations = {
	Element.FIRE: 4,
	Element.EARTH: 4,
	Element.WATER: 3,
	Element.LIGHT: 3,
	Element.DARK: 3,
	Element.AIR: 4,
	Element.JUNK: 1
}

var activeElement = Element.NONE
var activeDuration = 0
var weaponsQueue = []
@export var maxQueueSize = 5

var timer = 0

signal element_activated

func push(element):
	if weaponsQueue.size() < 5:
		weaponsQueue.push_back(element)

func pop():
	if weaponsQueue.size() > 0:
		return weaponsQueue.pop_front()

func activateElement():
	activeElement = pop()
	activeDuration = ElementDurations[activeElement]
	element_activated.emit(activeElement)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if activeDuration > 0:
		activeDuration -= delta
	if activeElement != Element.NONE and activeDuration <= 0:
		activeElement = Element.NONE
		if weaponsQueue.size():
			activateElement()
		else:
			element_activated.emit(Element.NONE)

func _on_object_detector_object_detected(detectedValue):
	print("signal received: ", detectedValue)
	if ElementUtils.DigitToElementMap.has(detectedValue):
		push(ElementUtils.DigitToElementMap[detectedValue])
	else:
		push(Element.JUNK)
	if activeElement == Element.NONE:
		activateElement()
