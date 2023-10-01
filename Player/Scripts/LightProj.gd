extends Area2D

@export var speed = 1000

@export var steerSpeed = 500

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = transform.x*speed
	var timer = Timer.new()
	self.add_child(timer)
	
	timer.connect("timeout", Callable(self, "queue_free"))
	timer.set_wait_time(10)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if target == null:
		var targets = get_tree().get_nodes_in_group("Enemy")
		if targets.size() > 0:
			target = targets.pick_random()
	else:
		var desired = (target.position - position).normalized() * speed
		var steer_Direction = (desired - velocity).normalized() * steerSpeed
		acceleration += steer_Direction
	velocity += acceleration * delta
	velocity = velocity.normalized() * speed
	rotation_degrees += 360*delta
	position += velocity * delta
