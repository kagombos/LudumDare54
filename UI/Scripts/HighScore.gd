extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	var scoreObj = SaveSystem.load_score()
	print(scoreObj)
	if scoreObj and scoreObj.score:
		text = "High Score: " + str(scoreObj.score)
	else:
		visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
