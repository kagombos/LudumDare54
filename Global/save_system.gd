extends Node

func save_score(data):
	print(data)
	print("saving")
	var score_file = FileAccess.open("user://score.save", FileAccess.WRITE)
	score_file.store_line(JSON.stringify(data))

func load_score():
	if not FileAccess.file_exists("user://score.save"):
		return
	var score_file = FileAccess.open("user://score.save", FileAccess.READ)
	var json_string = score_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	var data = json.get_data()
	return data
