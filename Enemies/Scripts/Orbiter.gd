extends RigidBody2D

@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

@export var orbitDirection = 1

@export var orbitRadius = 50

@export var accelRate = 1000

var turretCD = -1

var spawning = true

var despawning = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turretCD += delta
	look_at(get_global_mouse_position())
	if spawning:
		scale = Vector2(1.2-abs(turretCD),1.2-abs(turretCD))
		if turretCD >= 0.2:
			spawning = false
			scale = Vector2(1,1)
	else:
		if position.distance_to(get_global_mouse_position()) > orbitRadius * 1.25:
			apply_force(transform.x*accelRate)
		elif position.distance_to(get_global_mouse_position()) < orbitRadius * 0.75:
			apply_force(-transform.x*accelRate)
		else:
			apply_force(transform.y*accelRate*orbitDirection)
