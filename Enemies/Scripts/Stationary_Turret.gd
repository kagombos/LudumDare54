extends	StaticBody2D

@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

var turretCD = 0

var spawning = true

var despawning = false

func _ready():
	turretCD -= 1
	if has_node("Timer"):
		get_node("Timer").connect("timeout", Callable(self, "startDespawning"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turretCD += delta
	if spawning:
		scale = Vector2(1.2-abs(turretCD),1.2-abs(turretCD))
		if turretCD >= 0.2:
			spawning = false
			scale = Vector2(1,1)
	if turretCD >= fireRate and not despawning:
		turretCD -= fireRate
		var bullet_instance = bullet.instantiate()
		bullet_instance.position = $TurretBase/TurretAim/LaserPoint.get_global_position()
		bullet_instance.rotation = $TurretBase/TurretAim.rotation
		add_sibling(bullet_instance)
	if despawning:
		scale = Vector2(1-turretCD,1.-turretCD)
		if(turretCD >= 1):
			queue_free()

func startDespawning():
	despawning = true
	turretCD = 0
