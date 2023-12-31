extends Node2D

func _ready():
	Input.set_custom_mouse_cursor(preload("res://UI/Sprites/cursor.png"))
	if not MusicPlayer.get_node("MenuMusic").is_playing():
		MusicPlayer.get_node("MenuMusic").play()
	
	var file = FileAccess.open("user://handwritten_letters.onnx", FileAccess.WRITE)
	var file2 = FileAccess.get_file_as_bytes("res://handwritten_letters.txt")
	file.store_buffer(file2)
	file.close()

func start_game():
	get_tree().change_scene_to_file("res://arena.tscn")
	MusicPlayer.get_node("GameMusic").play()
	MusicPlayer.get_node("MenuMusic").stop()
	
func how_play():
	get_tree().change_scene_to_file("res://How_To_Play.tscn")

func tutorial():
	get_tree().change_scene_to_file("res://arenaTutorial.tscn")
	MusicPlayer.get_node("GameMusic").play()
	MusicPlayer.get_node("MenuMusic").stop()

func practice():
	get_tree().change_scene_to_file("res://arenaPractice.tscn")
	MusicPlayer.get_node("GameMusic").play()
	MusicPlayer.get_node("MenuMusic").stop()

func quit():
	get_tree().quit()
