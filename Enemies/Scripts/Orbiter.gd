extends RigidBody2D


@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

@export var orbitDirection = 1

@export var orbitRadius = 200

@export var accelRate = 200000

@export var canShoot = false

@export var maxHP = 10.0
@export var HP = 10.0

@export var resistChance = 0
@export var level = 0

@export var ResistanceTypes = {
	Element.FIRE: 1.0,
	Element.EARTH: 1.0,
	Element.LIGHT: 1.0,
	Element.DARK: 1.0,
	Element.AIR: 1.0,
	Element.JUNK: 1.0
}

var turretCD = -1

var spawning = true

var despawning = false

func _ready():
	var resistSelection = randf_range(0, 1000)
	if resistSelection <= resistChance:
		ResistanceTypes[Element.FIRE] = 0.1
		ResistanceTypes[Element.EARTH] = 0.1
		ResistanceTypes[Element.LIGHT] = 0.1
		ResistanceTypes[Element.DARK] = 0.1
		ResistanceTypes[Element.AIR] = 0.1
		ResistanceTypes[Element.JUNK] = 0
		var weaknessChance = randi_range(1, 3)
		if weaknessChance == 1:
			ResistanceTypes[Element.FIRE] = 1
			$Orbiter_Ship.texture = preload("res://Enemies/Sprites/enemyRed2.png")
		elif weaknessChance == 2:
			ResistanceTypes[Element.EARTH] = 1
			$Orbiter_Ship.texture = preload("res://Enemies/Sprites/enemyGreen2.png")
		elif weaknessChance == 3:
			ResistanceTypes[Element.DARK] = 1
			$Orbiter_Ship.texture = preload("res://Enemies/Sprites/enemyBlack2.png")
	maxHP = maxHP * ((level)*0.2+1)
	HP = maxHP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	turretCD += delta
	$Orbiter_Ship/OrbiterHPEmpty/OrbiterHPIndicator.scale = Vector2.ONE * HP/maxHP
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
	if HP <= 0:
		get_tree().get_nodes_in_group("Player")[0].XP += 10
		if ResistanceTypes[Element.JUNK] == 0:
			get_tree().get_nodes_in_group("Player")[0].XP += 20
		var particles = $DeathParticles
		remove_child(particles)
		particles.position = position
		add_sibling(particles)
		particles.visible = true
		particles.restart()
		queue_free()
		


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.HP -= 3.5
