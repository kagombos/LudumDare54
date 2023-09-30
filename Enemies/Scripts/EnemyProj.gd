extends RigidBody2D

@export var proj_speed = 40000

func _ready():
	apply_force(proj_speed * transform.x)
	var timer = Timer.new()
	self.add_child(timer)
	
	timer.connect("timeout", Callable(self, "queue_free"))
	timer.set_wait_time(5)
	timer.start()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.HP -= 5
		print(body.HP/body.maxHP)
		queue_free()
