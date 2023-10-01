extends WeaponBaseClass


var air_proj_prefab = preload("res://Player/Prefabs/air_proj.tscn")
var airCD = 0

func start_weapon():
	airCD = fireRate

func run_weapon(delta):
	airCD += delta
	if airCD > fireRate:
		airCD -= fireRate
		var air_proj = air_proj_prefab.instantiate()
		air_proj.position = owner.position
		air_proj.rotation = -owner.rotation
		air_proj.damage = damage
		owner.add_sibling(air_proj)
