extends Node2D

@export var text = ""
@export var step = 0
@export var showContinue = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/ColorRect/Label.text = text
	if not showContinue:
		$ColorRect/ColorRect/Button.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_up():
	print("button pressed ", step)
	owner.get_node("TutorialController")._on_tutorial_click(step)
	pass # Replace with function body.
