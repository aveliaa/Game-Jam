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

	if Input.is_action_just_released("enter"):
		shooting(false)
		
	if is_attacking:
		animate.play("shoot")
		
	else:
		if is_on_floor() and Input.is_action_just_pressed('up'):
			velocity.y = jump_speed
			
		elif Input.is_action_pressed('right'):
			velocity.x += speed
			run(true)
		
		elif Input.is_action_pressed('left'):
			velocity.x -= speed
			run(false)
	
		else:
			animate.play("default")

func _physics_process(delta):

	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)

func run(direction):
	is_right = direction
	
	animate.flip_h = !direction
	animate.play("run")

onready var shoot_right = $shoot_right/right
onready var shoot_left = $shoot_left/left
func shooting(is_shooting):
	is_attacking = is_shooting
	
	var disable_right = true
	var disable_left = true
	
	if is_shooting:
		$shoot.play()
		
		if is_right:
			disable_right = false
		else:
			disable_left = false
		
	shoot_right.disabled =  disable_right
	shoot_left.disabled = disable_left

onready var hp = $status/Hp
var remaining_hp = 100
func punch_damage(to_right,damage):
	if to_right:
		velocity.x += 3000
	else:
		velocity.x -= 3000
	
	remaining_hp = remaining_hp - damage
	hp.text = str(remaining_hp)
	
	move_and_slide(velocity, UP)

func shoot_damage(damage):
	remaining_hp = remaining_hp - damage
	hp.text = str(remaining_hp)

# One Hit
func _on_shoot_right_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()

func _on_shoot_left_body_entered(body):
	if body.has_method("player_damage"):
		body.player_damage()
