extends KinematicBody2D


export (int) var speed = 350
export (int) var GRAVITY = 1200
export (int) var jump_speed = -400

const UP = Vector2(0,-1)

var velocity = Vector2()

onready var animate = $AnimatedSprite

var is_attacking = false
var is_right = true

func get_input():
	velocity.x = 0
	
	if Input.is_action_just_pressed("enter"):
		shooting(true)
		#is_attacking = true
		#$shoot_right/right.disabled = false
		#$shoot_left/left.disabled = false
		
	if Input.is_action_just_released("enter"):
		shooting(false)
		#is_attacking = false
		#$shoot_right/right.disabled = true
		#$shoot_left/left.disabled = true
		
	if is_attacking:
		animate.play("shoot")
	else:
		if is_on_floor() and Input.is_action_just_pressed('up'):
			velocity.y = jump_speed
			#$Camera2D.current = false -> pas jatoh
		elif Input.is_action_pressed('right'):
			velocity.x += speed
			is_right = true
			
			animate.flip_h = false
			animate.play("run")
		
		elif Input.is_action_pressed('left'):
			velocity.x -= speed
			is_right = false
			
			animate.flip_h = true
			animate.play("run")
	
		else:
			animate.play("default")

func _physics_process(delta):

	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)

onready var shoot_right = $shoot_right/right
onready var shoot_left = $shoot_left/left
func shooting(is_shooting):
	is_attacking = is_shooting
	
	var disable_right = true
	var disable_left = true
	
	if is_shooting:
		if is_right:
			disable_right = false
		else:
			disable_left = false
		
	shoot_right.disabled =  disable_right
	shoot_left.disabled = disable_left

onready var hp = $status/Hp
func punch_damage(to_right,damage):
	if to_right:
		velocity.x += 3000
	else:
		velocity.x -= 3000
		
	hp.text = str(int(hp.text) - damage)
	
	move_and_slide(velocity, UP)
	
	# TODO: cant move when cornered : idea : danger area. jadi pas collide langsung health ----

# Note : agak tebalik ya bun
# attack pake for loop
func _on_shoot_right_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()

func _on_shoot_left_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()
