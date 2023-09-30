extends CharacterBody2D

var last_position

@export var maxHP = 500.0
@export var HP = 500.0

func _ready():
	HP = maxHP
	last_position = get_global_mouse_position()
	position = get_global_mouse_position() 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	position = get_global_mouse_position()
	if position != last_position:
		look_at(last_position)
	last_position = position
	$Base_Ship/Health_Bar_Empty/Health_Bar.scale.x = HP/maxHP
	if HP <= 0:
		#replace this with game over code
		queue_free()
