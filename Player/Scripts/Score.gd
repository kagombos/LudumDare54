extends RichTextLabel

var timer = 0
var xp = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	xp = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if owner.has_node("Player"):
		xp = owner.get_node("Player").cumulativeXP
	timer += delta
	text = str(floor(timer) + xp)
	pass
