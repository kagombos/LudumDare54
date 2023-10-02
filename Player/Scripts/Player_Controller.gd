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


@export var XP = 0
var levelThreshold = 50

var end_game = false
var end_game_timer = 2

func _ready():
	$DeathParticles.visible = false
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
	if not end_game:
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
			HP = 0

		if ElementToScene.has(activeElement):
			ElementToScene[activeElement].active = true

		if XP >= levelThreshold:
			XP -= levelThreshold
			levelThreshold *= 1.1
			$Upgrade_Spawner.level_up()
		if HP <= 0:
			$DeathParticles.visible = true
			$DeathParticles.restart()
			$AudioDeath.pitch_scale = 0.7 + randf_range(-0.2, 0.2)
			$AudioDeath.play()
			$Base_Ship.visible = false
			end_game = true
			end_game_timer = 2
			#replace this with game over code
	else:
		end_game_timer -= delta
		if end_game_timer <= 0:
			get_tree().change_scene_to_file("res://Main Menu.tscn")
			MusicPlayer.get_node("GameMusic").stop()

func _on_weapons_queue_element_activated(element):
	activeElement = element
	

func _on_object_detector_object_detected(detectedValue):
	if ElementUtils.DigitToElementMap.has(detectedValue):
		$DrawSuccess.restart()
