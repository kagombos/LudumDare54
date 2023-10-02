extends Area2D

@export var speed = 1000

@export var steerSpeed = 500

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
@export var damage = 1
@export var pierce = 0.0

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
	var bodies = get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies && scale.x > 0.01:
		bodies[0].HP -= damage*(bodies[0].ResistanceTypes[Element.LIGHT]+pierce)
		bodies[0].play_collision()
		var particles = $GPUParticles2D
		if particles:
			remove_child(particles)
			particles.position = position
			particles.emitting = false
			get_parent().add_child(particles)
		queue_free()
	var areas = get_overlapping_areas()
	areas = areas.filter(func(area): return area.get_groups().has("Enemy"))
	if areas && scale.x > 0.01:
		areas[0].HP -= damage*(areas[0].ResistanceTypes[Element.LIGHT]+pierce)
		areas[0].play_collision()
		var particles = $GPUParticles2D
		if particles:
			remove_child(particles)
			particles.position = position
			particles.emitting = false
			get_parent().add_child(particles)
		queue_free()
