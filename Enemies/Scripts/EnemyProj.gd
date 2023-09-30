extends RigidBody2D

@export var proj_speed = 20000

func _ready():
	apply_force(proj_speed * transform.x)
