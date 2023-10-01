extends CharacterBody2D

@export var light_proj_prefab = preload("res://Player/Prefabs/light_proj.tscn")

var lightActive = false

var last_position
var rotation_locked

@export var maxHP = 500.0
@export var HP = 500.0

@export var lightFireRate = 0.5

var lightCD = 0

func _ready():
	HP = maxHP
	last_position = get_global_mouse_position()
	position = get_global_mouse_position() 
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
	if Input.is_action_pressed("Light_Debug"):
		lightActive = true
	else:
		lightActive = false
	if lightActive:
		lightCD += delta
		if lightCD > lightFireRate:
			lightCD -= lightFireRate
			var light_proj = light_proj_prefab.instantiate()
			light_proj.position = position
			light_proj.rotation = rotation
			add_sibling(light_proj)
	if HP <= 0:
		#replace this with game over code
		queue_free()
