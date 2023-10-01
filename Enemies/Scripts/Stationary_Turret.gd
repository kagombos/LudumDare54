extends	StaticBody2D

@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

var turretCD = -1

var spawning = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turretCD += delta
	if spawning:
		scale = Vector2(1.2-abs(turretCD),1.2-abs(turretCD))
		if turretCD >= 0.2:
			spawning = false
			scale = Vector2(1,1)
	if turretCD >= fireRate:
		turretCD -= fireRate
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = $TurretBase/TurretAim/LaserPoint.get_global_position()
		bullet_instance.rotation = $TurretBase/TurretAim.rotation
		add_sibling(bullet_instance)
