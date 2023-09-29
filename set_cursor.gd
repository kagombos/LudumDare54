extends Node

var cursor = load('res://controller.jpg')

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(cursor)
