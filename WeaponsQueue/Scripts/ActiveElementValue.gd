extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	#var element_utils = get_node("/root/ElementUtils")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = ElementUtils.ElementToString[owner.activeElement]
