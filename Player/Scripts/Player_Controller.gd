extends CharacterBody2D

var ElementToScene
@export var earth_proj_prefab = preload("res://Player/Prefabs/earth_proj.tscn")

var activeElement = Element.NONE

var earthActive = false
var lightActive = false
var darkActive = false
var darkHP = 500.0

var last_position
var rotation_locked

@export var maxHP = 500.0
@export var HP = 500.0

@export var lightFireRate = 0.5
@export var earthFireRate = 2

var lightCD = 0
var earthCD = 0

func _ready():
	HP = maxHP
	last_position = get_global_mouse_position()
	position = get_global_mouse_position()
	ElementToScene = {
		Element.FIRE: $Weapon_Fire,
		Element.WATER: $Weapon_Water,
		Element.DARK: $Weapon_Dark,
		Element.LIGHT: $Weapon_Light,
	}
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event is InputEventMouseButton and event.button_index == 2:
		if event.pressed:
			rotation_locked = true
		else:
			rotation_locked = false

func _physics_process(delta):
	position = get_global_mouse_position()
	if position != last_position and not rotation_locked:
		look_at(last_position)
	last_position = position
	$Base_Ship/Health_Bar_Empty/Health_Bar.scale.x = HP/maxHP
	
	ElementToScene.values().map(func (weapon): weapon.active = false)
	
	if Input.is_action_pressed("Earth_Debug"):
		earthActive = true
	else:
		earthActive = false
	if Input.is_action_pressed("Light_Debug"):
		lightActive = true
	else:
		lightActive = false
	if Input.is_action_just_pressed("Dark_Debug"):
		darkHP = HP
	if Input.is_action_pressed("Dark_Debug"):
		$Weapon_Dark.active = true
	else:
		$Weapon_Dark.active = false
#	if darkActive:
#		if HP < darkHP:
#			HP = darkHP
#		else:
#			darkHP = HP

	if ElementToScene.has(activeElement):
		ElementToScene[activeElement].active = true
	
	if earthActive:
		earthCD += delta
		if earthCD > earthFireRate:
			earthCD -= earthFireRate
			for i in range(5):
				var earth_proj = earth_proj_prefab.instantiate()
				earth_proj.rotation_degrees = rotation_degrees + 72*i
				earth_proj.position = earth_proj.transform.x * 20
				add_child(earth_proj)
	if HP <= 0:
		#replace this with game over code
		queue_free()

func _on_weapons_queue_element_activated(element):
	activeElement = element
