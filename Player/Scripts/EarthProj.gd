extends Area2D

@export var speed = 1000

var velocity = Vector2.ZERO

@export var orbitDirection = -1

@export var orbitRadius = 120
@export var damage = 1
@export var pierce = 0.0



func _ready():
	var timer = Timer.new()
	self.add_child(timer)
	
	timer.connect("timeout", Callable(self, "queue_free"))
	timer.set_wait_time(2.5)
	timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2.ZERO
	look_at(get_global_mouse_position())
	if position.distance_to(get_global_mouse_position()) < orbitRadius:
		velocity = (transform.x*speed*delta)
	velocity += (transform.y*speed*orbitDirection*0.05*delta)
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	var bodies = get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies && scale.x > 0.01:
		bodies[0].HP -= damage*(bodies[0].ResistanceTypes[Element.EARTH]+pierce)
		queue_free()
	var areas = get_overlapping_areas()
	areas = areas.filter(func(area): return area.get_groups().has("Enemy"))
	if areas && scale.x > 0.01:
		areas[0].HP -= damage*(areas[0].ResistanceTypes[Element.EARTH]+pierce)
		queue_free()
