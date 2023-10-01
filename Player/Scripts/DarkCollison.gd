extends Area2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies && scale.x > 0.01:
		for i in bodies:
			i.HP -= 15*delta*i.ResistanceTypes[Element.DARK]
	var areas = get_overlapping_areas()
	areas = areas.filter(func(area): return area.get_groups().has("Enemy"))
	if areas && scale.x > 0.01:
		for i in areas:
			i.HP -= 15*delta*i.ResistanceTypes[Element.DARK]
