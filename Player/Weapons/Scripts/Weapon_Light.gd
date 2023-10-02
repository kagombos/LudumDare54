extends WeaponBaseClass

var light_proj_prefab = preload("res://Player/Prefabs/light_proj.tscn")
var lightCD = fireRate

func run_weapon(delta):
	lightCD += delta
	if lightCD > fireRate:
		lightCD -= fireRate
		var light_proj = light_proj_prefab.instantiate()
		light_proj.position = owner.position
		light_proj.rotation = owner.rotation
		light_proj.damage = power
		light_proj.pierce = pierce
		owner.add_sibling(light_proj)
