extends Node

@export var tutorial = false
var cursor = load('res://Player/Sprites/Game_Cursor.png')

# Called when the node enters the scene tree for the first time.
func _ready():
	if not tutorial:
		Input.set_custom_mouse_cursor(cursor)

