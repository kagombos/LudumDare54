extends Node2D

var sprites = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in range(owner.maxQueueSize):
		var sprite = Sprite2D.new()
		sprite.position = Vector2(100 + n * 37.5, 37.5)
		sprite.scale = Vector2(0.25, 0.25)
		add_child(sprite)
		sprites.append(sprite)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	for n in range(owner.maxQueueSize):
		if n < owner.weaponsQueue.size():
			sprites[n].visible = true
			sprites[n].texture = ImageTexture.create_from_image(ElementUtils.ElementToIcon[owner.weaponsQueue[n]])
		else:
			sprites[n].visible = false
