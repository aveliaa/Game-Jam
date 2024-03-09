extends KinematicBody2D



export (int) var speed = 300
export (int) var GRAVITY = 1200
export (int) var jump_speed = -400

const UP = Vector2(0,-1)

var velocity = Vector2()

onready var kai_anim = $KaiAnim

func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		#$Camera2D.current = false -> pas jatoh
	elif Input.is_action_pressed('right'):
		velocity.x += speed
		if Input.is_action_just_pressed("right"):
			kai_anim.flip_h = true
			kai_anim.play("walk")
		
	elif Input.is_action_pressed('left'):
		velocity.x -= speed
		if Input.is_action_just_pressed("left"):
			kai_anim.flip_h = false
			kai_anim.play("walk")
			
	else:
		kai_anim.play("default")

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
	
# onready var summer_anim = $"../summer/SummerAnim"

