extends RichTextLabel

var timer = 0
var xp = 0
var player_dead = false
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	xp = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not owner.get_node("Player").end_game:
		xp = owner.get_node("Player").cumulativeXP
		timer += delta
		score = floor(timer) + xp
		text = str(score)
	elif not player_dead:
		print("player died")
		player_dead = true
		var highScore = SaveSystem.load_score()
		if highScore and highScore.score:
			SaveSystem.save_score({"score": max(highScore.score, score)})
		else:
			print(score)
			SaveSystem.save_score({"score": score})
