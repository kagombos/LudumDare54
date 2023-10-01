extends WeaponBaseClass

@export var waterParticle = preload("res://Player/Prefabs/water_particle.tscn")
var particleCD = fireRate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func run_weapon(delta):
	if owner.HP < owner.maxHP:
		particleCD+=delta
		owner.HP += delta*10
		if owner.HP > owner.maxHP:
			owner.HP = owner.maxHP
		if particleCD >= fireRate:
			particleCD-= fireRate
			var particleGen = waterParticle.instantiate()
			particleGen.position = position + transform.y * randf_range(-40, 40) + transform.x * randf_range(-10, 10)
			particleGen.rotation_degrees = rotation_degrees
			add_child(particleGen) 
