extends Node2D

@export var spawnRate = 8
@export var enemy_prefab = preload("res://Enemies/Prefabs/turret_stationary.tscn")
@export var enemyDelay = 1

@export var minSpawnDist = 100
@export var maxSpawnDist = 200

var spawnCD = 0
var enemyLevel = 0
var levelThreshold = 0
var gameLifetime = -20
var screenSize

func _ready():
	screenSize = get_viewport_rect().size
	#test code
	spawnCD = spawnRate-enemyDelay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnCD += delta
	gameLifetime += delta
	if gameLifetime >= levelThreshold:
		enemyLevel += 1
		levelThreshold += 10*enemyLevel
	if spawnCD >= spawnRate:
		spawnCD -= spawnRate
		var enemy_instance = enemy_prefab.instantiate()
		var enemyX = randf_range(minSpawnDist, maxSpawnDist)
		var enemyY = randf_range(minSpawnDist, maxSpawnDist) 
		enemy_instance.position = get_global_mouse_position()+Vector2(enemyX*(-1 +2*randi_range(0, 1)), enemyY*(-1 +2*randi_range(0, 1)))
		enemy_instance.resistChance = gameLifetime*2
		enemy_instance.level = enemyLevel
		if enemy_instance.position.x < 25:
			enemy_instance.position.x += enemyX*2
		if enemy_instance.position.y < 25:
			enemy_instance.position.y += enemyY*2
		if enemy_instance.position.x > screenSize.x - 25:
			enemy_instance.position.x -= enemyX*2
		if enemy_instance.position.y < screenSize.y -25:
			enemy_instance.position.y -= enemyY*2
		add_child(enemy_instance)
		
		
		
		
