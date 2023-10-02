extends Node2D

var cursor = load('res://UI/Sprites/cursor.png')
var enemy = preload("res://Enemies/Prefabs/orbiter.tscn")

var step = 0
var stageFuncArray = [stage1, stage2, stage3, stage4, stage5, stage6, stage7, stage8]

# Called when the node enters the scene tree for the first time.
func _ready():
	get_children().map(func(child): child.visible = false)
	owner.get_node("TrailControlLeft").visible = false
	
	$TutorialWindow1.visible = true
	owner.get_node("Player").visible = false
	Input.set_custom_mouse_cursor(cursor)
	pass # Replace with function body.

func stage1():
	$TutorialWindow1.visible = false
	$TutorialWindow2.visible = true
	step = 1
	owner.get_node("Player").visible = true

func stage2():
	$TutorialWindow2.visible = false
	$TutorialWindow3.visible = true
	step = 2
	owner.get_node("TrailControlLeft").visible = true

func stage3():
	$TutorialWindow3.visible = false
	$TutorialWindow4.visible = true
	step = 3

func stage4():
	$TutorialWindow4.visible = false
	$TutorialWindow5.visible = true
	add_sibling(enemy.instantiate())
	step = 4

func stage5():
	$TutorialWindow5.visible = false
	$TutorialWindow6.visible = true
	owner.get_node("Player").get_node("Upgrade_Spawner").level_up()
	step = 5

func stage6():
	$TutorialWindow6.visible = false
	$TutorialWindow7.visible = true
	var resistEnemy = enemy.instantiate()
	resistEnemy.level = 100
	add_sibling(resistEnemy)
	resistEnemy.HP = 20
	step = 6
	
func stage7():
	$TutorialWindow7.visible = false
	$TutorialWindow8.visible = true
	step = 7
	
func stage8():
	get_tree().change_scene_to_file("res://Main Menu.tscn")
	MusicPlayer.get_node("GameMusic").stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if step == 4 and not owner.has_node("Orbiter"):
		stage5()
	if step == 5 and not owner.has_node("Upgrades_Parent"):
		stage6()
	if step == 6 and not owner.has_node("Orbiter"):
		stage7()
	pass

func _on_tutorial_click(step):
	stageFuncArray[step].call()
	pass # Replace with function body.

func _on_draw_element(element):
	if step == 2:
		stage3()
	pass # Replace with function body.
