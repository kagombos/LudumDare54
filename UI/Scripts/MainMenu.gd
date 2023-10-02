extends Node2D


func _ready():
	Input.set_custom_mouse_cursor(preload("res://UI/Sprites/cursor.png"))

func start_game():
	get_tree().change_scene_to_file("res://arena.tscn")
	
	
func how_play():
	get_tree().change_scene_to_file("res://How_To_Play.tscn")

func practice():
	get_tree().change_scene_to_file("res://arenaPractice.tscn")

func quit():
	get_tree().quit()
