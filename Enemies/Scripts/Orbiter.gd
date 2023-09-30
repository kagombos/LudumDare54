extends RigidBody2D

@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

@export var orbitDirection = 1

@export var orbitRadius = 200

@export var accelRate = 200000

@export var canShoot = false

var turretCD = -1

var spawning = true

var despawning = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	turretCD += delta
	look_at(get_global_mouse_position())
	if spawning:
		scale = Vector2(1.2-abs(turretCD),1.2-abs(turretCD))
		if turretCD >= 0.2:
			spawning = false
			scale = Vector2(1,1)
	else:
		if position.distance_to(get_global_mouse_position()) > orbitRadius * 1.5:
			apply_force(transform.x*accelRate*delta)
		elif position.distance_to(get_global_mouse_position()) < orbitRadius:
			apply_force(-transform.x*accelRate*delta)
		else:
			apply_force(transform.y*accelRate*orbitDirection*0.4*delta)
	if turretCD >= fireRate and canShoot:
		turretCD -= fireRate
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = $LaserPoint.get_global_position()
		bullet_instance.rotation = rotation
		add_sibling(bullet_instance)
		
