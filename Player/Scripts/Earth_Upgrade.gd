extends Area2D


var statChoice
# Called when the node enters the scene tree for the first time.
func _ready():
	statChoice = randi_range(0, 2)
	if statChoice == 0:
		$Sprite2D.texture = preload("res://Player/Sprites/powerupGreen_star.png")
	elif statChoice == 1:
		$Sprite2D.texture = preload("res://Player/Sprites/powerupGreen_shield.png")
	elif statChoice == 2:
		$Sprite2D.texture = preload("res://Player/Sprites/powerupGreen_bolt.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not owner.spawning:
		var bodies = get_overlapping_bodies()
		bodies = bodies.filter(func(body): return body.get_groups().has("Player"))
		if bodies.size() > 0:
			for i in bodies:
				if statChoice == 0:
					i.get_node("Weapon_Earth").power *= 1.5
				if statChoice == 1:
					i.get_node("Weapon_Earth").pierce += 0.1
				if statChoice == 2:
					i.get_node("Weapon_Earth").fireRate *= 0.85
			owner.queue_free()
