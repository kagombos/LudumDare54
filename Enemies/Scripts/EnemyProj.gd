extends RigidBody2D

@export var proj_speed = 1000

func _physics_process(delta):
	position += transform.x * proj_speed * delta
