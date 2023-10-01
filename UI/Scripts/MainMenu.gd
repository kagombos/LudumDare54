extends Node2D


func start_game():
	get_tree().change_scene_to_file("res://arena.tscn")
	
	
func how_play():
	pass

func practice():
	get_tree().change_scene_to_file("res://arenaPractice.tscn")

func quit():
	get_tree().quit()
