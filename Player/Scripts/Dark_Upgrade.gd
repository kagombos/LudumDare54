extends Area2D

var statChoice
# Called when the node enters the scene tree for the first time.
func _ready():
	statChoice = randi_range(0, 1)
	if statChoice == 0:
		$Sprite2D.texture = preload("res://Player/Sprites/powerupBlack_star.png")
	elif statChoice == 1:
		$Sprite2D.texture = preload("res://Player/Sprites/powerupBlack_shield.png")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies.size() > 0:
		if statChoice == 0:
			bodies[0].get_node("Weapon_Dar").power *= 1.5
		if statChoice == 1:
			bodies[0].get_node("Weapon_Earth").pierce += 0.1
		owner.queue_free()
