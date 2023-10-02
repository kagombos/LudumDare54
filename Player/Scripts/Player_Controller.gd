extends CharacterBody2D

var ElementToScene

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
		Element.EARTH: $Weapon_Earth,
		Element.AIR: $Weapon_Air,
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
	
	# set all to false
	ElementToScene.values().map(func (weapon): weapon.active = false)
	
	if Input.is_action_pressed("Fire_Debug"):
		$Weapon_Fire.active = true
	if Input.is_action_pressed("Water_Debug"):
		$Weapon_Water.active = true
	if Input.is_action_pressed("Dark_Debug"):
		$Weapon_Dark.active = true
	if Input.is_action_pressed("Earth_Debug"):
		$Weapon_Earth.active = true
	if Input.is_action_pressed("Light_Debug"):
		$Weapon_Light.active = true
	if Input.is_action_pressed("Air_Debug"):
		$Weapon_Air.active = true

	if ElementToScene.has(activeElement):
		ElementToScene[activeElement].active = true

	if HP <= 0:
		#replace this with game over code
		queue_free()

func _on_weapons_queue_element_activated(element):
	activeElement = element


func _on_object_detector_object_detected(detectedValue):
	if ElementUtils.DigitToElementMap.has(detectedValue):
		$DrawSuccess.restart()
