extends WeaponBaseClass

# Called when the node enters the scene tree for the first time.
func _ready():
	$FireCone.scale = Vector2.ZERO
	$FireCone.position = Vector2.ZERO
	$FireCone/AnimatedSprite2D.play("default")

func grow_flames(delta):
	$FireCone.position.x -= 150*delta
	$FireCone.scale += Vector2.ONE*delta
	if $FireCone.scale.x > 1:
		$FireCone.position.x = -150
		$FireCone.scale = Vector2.ONE

func shrink_flames(delta):
	$FireCone.position.x += 150*delta
	$FireCone.scale -= Vector2.ONE*delta
	if $FireCone.scale.x < 0:
		$FireCone.position.x = 0
		$FireCone.scale = Vector2.ZERO

func run_weapon(delta):
	if $FireCone.scale.x < 1:
		grow_flames(delta)
	
	var bodies = $FireCone.get_overlapping_bodies()
	bodies = bodies.filter(func(body): return body.get_groups().has("Enemy"))
	if bodies && $FireCone.scale.x > 0.01:
		for i in bodies:
			i.HP -= 10*delta

func wind_down_weapon(delta):
	if $FireCone.scale.x > 0:
		shrink_flames(delta)
	else:
		winding_down = false
