extends WeaponBaseClass


# Called when the node enters the scene tree for the first time.
func _ready():
	$DarkCollision.scale = Vector2.ZERO

func start_weapon():
	$DarkCollision/DarkShield.play("default")
	$DarkCollision.scale = Vector2.ONE
	
func stop_weapon():
	$DarkCollision/DarkShield.stop()
	$DarkCollision.scale = Vector2.ZERO

func run_weapon(delta):
	var bodies = $DarkCollision.get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies && $DarkCollision.scale.x > 0.01:
		for i in bodies:
			i.HP -= 15*delta*i.ResistanceTypes[Element.DARK]
	var areas = $DarkCollision.get_overlapping_areas()
	areas = areas.filter(func(area): return area.get_groups().has("Enemy"))
	if areas && $DarkCollision.scale.x > 0.01:
		for i in areas:
			i.HP -= 15*delta*i.ResistanceTypes[Element.DARK]
