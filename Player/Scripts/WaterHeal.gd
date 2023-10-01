extends Node2D

@export var waterParticle = preload("res://Player/Prefabs/water_particle.tscn")

var waterActive = false
var particleCD = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Water_Debug"):
		waterActive=true
	else:
		waterActive=false
	if waterActive and owner.HP < owner.maxHP:
		particleCD+=delta
		owner.HP += delta*10
		if owner.HP > owner.maxHP:
			owner.HP = owner.maxHP
		if particleCD >= 0.3:
			particleCD-= 0.3
			var particleGen = waterParticle.instantiate()
			particleGen.position = position + transform.y * randf_range(-40, 40) + transform.x * randf_range(-10, 10)
			particleGen.rotation_degrees = rotation_degrees
			add_child(particleGen) 
