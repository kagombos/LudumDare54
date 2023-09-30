extends	StaticBody2D

@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

var turretCD = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turretCD += delta
	if turretCD >= fireRate:
		turretCD -= fireRate
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = $TurretBase/TurretAim/LaserPoint.get_global_position()
		bullet_instance.rotation = $TurretBase/TurretAim.rotation
		owner.add_child(bullet_instance)
