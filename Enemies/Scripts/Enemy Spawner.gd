extends Node2D

@export var spawnRate = 4
@export var enemy_prefab = preload("res://Enemies/Prefabs/turret_stationary.tscn")
@export var enemyLifetime = 20

@export var minSpawnDist = 100
@export var maxSpawnDist = 200

var spawnCD = 0
var screenSize

func _ready():
	screenSize = get_viewport_rect().size
	#test code
	spawnCD = spawnRate-1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnCD += delta
	if spawnCD >= spawnRate:
		spawnCD -= spawnRate
		var enemy_instance = enemy_prefab.instantiate()
		var enemyX = randf_range(minSpawnDist, maxSpawnDist)
		var enemyY = randf_range(minSpawnDist, maxSpawnDist) 
		enemy_instance.position = get_global_mouse_position()+Vector2(enemyX*(-1 +2*randi_range(0, 1)), enemyY*(-1 +2*randi_range(0, 1)))
		var timer = Timer.new()
		enemy_instance.add_child(timer)
		add_child(enemy_instance)
		timer.set_wait_time(enemyLifetime)
		timer.start()
		
		
		
		
