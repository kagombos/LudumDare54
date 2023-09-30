extends RigidBody2D

@export var proj_speed = 40000

func _ready():
	apply_force(proj_speed * transform.x)
	var timer = Timer.new()
	self.add_child(timer)
	
	timer.connect("timeout", Callable(self, "queue_free"))
	timer.set_wait_time(5)
	timer.start()
