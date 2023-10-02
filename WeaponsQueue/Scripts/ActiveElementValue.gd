extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#var element_utils = get_node("/root/ElementUtils")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ElementUtils.ElementToIcon.has(owner.activeElement):
		texture = ImageTexture.create_from_image(ElementUtils.ElementToIcon[owner.activeElement])
	else:
		texture = null
