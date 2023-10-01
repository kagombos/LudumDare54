extends Area2D


@export var speed = 300

@export var steerSpeed = 200

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

var fullSize = false
var alpha = 1.0
var despawning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ZERO
	velocity = transform.x*speed
	var timer = Timer.new()
	self.add_child(timer)
	
	timer.connect("timeout", Callable(self, "winding_down"))
	timer.set_wait_time(8)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not fullSize:
		scale += Vector2.ONE * 0.1*delta
		if(scale.x > 0.5):
			fullSize = true
	if despawning:
		scale -= Vector2.ONE * 0.1*delta
		alpha -= 0.2*delta
		if alpha <= 0.01:
			queue_free()
		$Tornado.modulate = Color(1, 1, 1, alpha)
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
	var bodies = get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies && scale.x > 0.01:
		bodies[0].HP -= 5*bodies[0].ResistanceTypes[Element.AIR]*delta*alpha
	var areas = get_overlapping_areas()
	areas = areas.filter(func(area): return area.get_groups().has("Enemy"))
	if areas && scale.x > 0.01:
		areas[0].HP -= 5*areas[0].ResistanceTypes[Element.AIR]*delta*alpha
		
func winding_down():
	despawning = true
