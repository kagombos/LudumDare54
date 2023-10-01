extends WeaponBaseClass

@export var earth_proj_prefab = preload("res://Player/Prefabs/earth_proj.tscn")
var earthCD = 0

func start_weapon():
	earthCD = fireRate
	
func process(delta):
	rotation_degrees = -owner.rotation_degrees

func run_weapon(delta):
	earthCD += delta
	if earthCD > fireRate:
		earthCD -= fireRate
		for i in range(5):
			var earth_proj = earth_proj_prefab.instantiate()
			earth_proj.rotation_degrees = rotation_degrees + 72*i
			earth_proj.position = earth_proj.transform.x * 20
			add_child(earth_proj)
