extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = preload("res://Player/Sprites/powerupBlue_star.png")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies.size() > 0:
		bodies[0].get_node("Weapon_Water").power *= 1.5
		owner.queue_free()
