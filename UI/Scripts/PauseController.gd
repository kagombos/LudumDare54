extends Node2D

var cursor = load("res://UI/Sprites/cursor.png")
var gameCursor = load("res://Player/Sprites/Game_Cursor.png")
var currentlyPaused = false
var mousePos

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseMenu.visible = false
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Pause_Menu"):
		if currentlyPaused:
			unpause()
		else:
			pause()

func pause():
	get_tree().paused = true
	currentlyPaused = true
	Input.set_custom_mouse_cursor(cursor)
	$PauseMenu.visible = true
	mousePos = get_viewport().get_mouse_position()

func unpause():
	get_tree().paused = false
	currentlyPaused = false
	Input.set_custom_mouse_cursor(gameCursor)
	$PauseMenu.visible = false
	get_viewport().warp_mouse(mousePos)

func quit_to_menu():
	unpause()
	get_tree().change_scene_to_file("res://Main Menu.tscn")
	MusicPlayer.get_node("GameMusic").stop()

func quit_to_desktop():
	get_tree().quit()
