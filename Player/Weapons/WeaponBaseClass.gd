class_name WeaponBaseClass
extends Node2D

var lastTickActive = false
var active = false
var winding_down = false

@export var physics_weapon = true
@export_range(0, 100, 0.1) var fireRate: float = 0

func _process(delta):
	process(delta)
	if not physics_weapon:
		weapons_process(delta)

func _physics_process(delta):
	if physics_weapon:
		weapons_process(delta)

func weapons_process(delta):
	if not lastTickActive and active:
		start_weapon()
	
	if lastTickActive and not active:
		stop_weapon()
	
	if active:
		run_weapon(delta)
		
	if winding_down:
		wind_down_weapon(delta)
	
	lastTickActive = active

func process(delta):
	pass

func start_weapon():
	pass

func run_weapon(delta):
	pass

func stop_weapon():
	pass

func wind_down_weapon(delta):
	pass
