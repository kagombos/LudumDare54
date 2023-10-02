extends	Area2D


@export var bullet = preload("res://Enemies/Prefabs/Projectiles/turret_laser_1.tscn")

@export var fireRate = 1

@export var maxHP = 20.0
@export var HP = 20.0

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
			$TurretBase.texture = preload("res://Enemies/Sprites/ufoRed.png")
			$TurretBase/TurretAim.texture = preload("res://Enemies/Sprites/cockpitRed_5.png")
		elif weaknessChance == 2:
			ResistanceTypes[Element.EARTH] = 1
			$TurretBase.texture = preload("res://Enemies/Sprites/ufoGreen.png")
			$TurretBase/TurretAim.texture = preload("res://Enemies/Sprites/cockpitGreen_7.png")
		elif weaknessChance == 3:
			ResistanceTypes[Element.LIGHT] = 1
			$TurretBase.texture = preload("res://Enemies/Sprites/ufoYellow.png")
			$TurretBase/TurretAim.texture = preload("res://Enemies/Sprites/cockpitYellow_3.png")
	maxHP = maxHP * ((level)*0.2+1)
	HP = maxHP
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
	$TurretBase/TurretAim/Health_Bar_Empty/Health_Bar.scale.x = HP/maxHP
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
