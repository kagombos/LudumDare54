extends CharacterBody2D

var last_position
var rotation_locked

@export var maxHP = 500.0
@export var HP = 500.0

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
		

func _physics_process(_delta):
	position = get_global_mouse_position()
	if position != last_position and not rotation_locked:
		look_at(last_position)
	last_position = position
	$Base_Ship/Health_Bar_Empty/Health_Bar.scale.x = HP/maxHP
	if HP <= 0:
		#replace this with game over code
		queue_free()
