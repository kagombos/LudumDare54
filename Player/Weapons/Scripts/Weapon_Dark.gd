extends WeaponBaseClass


# Called when the node enters the scene tree for the first time.
func _ready():
	$DarkShield.scale = Vector2.ZERO

func start_weapon():
	$DarkShield.play("default")
	$DarkShield.scale = Vector2.ONE
	
func stop_weapon():
	$DarkShield.stop()
	$DarkShield.scale = Vector2.ZERO
