extends Node2D

@export var spawnRate = 0.5
@export var enemy_prefab = preload("res://Enemies/Prefabs/turret_stationary.tscn")
@export var enemy_prefab1 = preload("res://Enemies/Prefabs/orbiter.tscn")
@export var waveRate = 6.0
@export var waveSize = 2
@export var waveGrowth = 2
@export var enemyDelay = 1

var waveSpawning = false

@export var minSpawnDist = 100
@export var maxSpawnDist = 200

var spawnCD = 0
var waveCD = 0
var enemiesLeftInWave = 0
var enemyLevel = 0
var levelThreshold = 0
var screenSize

func _ready():
	screenSize = get_viewport_rect().size
	#test code
	waveCD = waveRate-enemyDelay

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not waveSpawning:
		waveCD += delta
		if waveCD >= waveRate:
			waveCD -= waveRate
			waveSpawning = true
			enemyLevel += 1
			enemiesLeftInWave = waveSize
			waveSize += waveGrowth
			waveRate += waveGrowth
	if waveSpawning:
		spawnCD += delta
		if spawnCD >= spawnRate:
			enemiesLeftInWave -= 1
			spawnCD -= spawnRate
			if enemiesLeftInWave <= 0:
				waveSpawning = false
			var enemies = [enemy_prefab, enemy_prefab1]
			var enemy_instance = enemies[randi()%enemies.size()].instantiate()
			$SpawnSound.play()
			var enemyX = randf_range(minSpawnDist, maxSpawnDist)
			var enemyY = randf_range(minSpawnDist, maxSpawnDist) 
			enemy_instance.position = get_global_mouse_position()+Vector2(enemyX*(-1 +2*randi_range(0, 1)), enemyY*(-1 +2*randi_range(0, 1)))
			enemy_instance.level = enemyLevel
			if enemy_instance.position.x < 50:
				enemy_instance.position.x += enemyX*2
			if enemy_instance.position.y < 50:
				enemy_instance.position.y += enemyY*2
			if enemy_instance.position.x > screenSize.x - 50:
				enemy_instance.position.x -= enemyX*2
			if enemy_instance.position.y < screenSize.y -50:
				enemy_instance.position.y -= enemyY*2
			add_sibling(enemy_instance)
		
		
		
		
