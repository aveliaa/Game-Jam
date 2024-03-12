extends KinematicBody2D

export (int) var speed = 0.5
export (int) var GRAVITY = 1200
export (int) var jump_speed = -400

onready var character = $character

const UP = Vector2(0,-1)

var velocity = Vector2()

func _ready():
	walk(false)
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if is_alive:
		if player:
			chase()
		else:
			move()
		velocity = move_and_slide(velocity, UP)
	

# Mode
func chase():	
	if go_right:
		run(false)
		velocity.x += speed + 2
	else:
		run(true)
		velocity.x -= speed	+ 2
	
var go_right = true
func move():	
	if go_right:
		velocity.x += speed
	else:
		velocity.x -= speed	
		
func run(direction):
	character.flip_h = direction
	if !is_attacking:
		character.play("run")
	
func walk(direction):
	character.flip_h = direction
	character.play("walk")

# Left Limit
func _on_patrol_left_body_entered(body):
	if body.name == "EnermyBeginner" and player == null:
		in_limit(true)

# Right Limit
func _on_patrol_right_body_entered(body):
	if body.name == "EnermyBeginner" and player == null:
		in_limit(false)

func in_limit(direction_right):
		character.play("default")
		yield(get_tree().create_timer(2),"timeout")
		walk(!direction_right)
		go_right = direction_right
	
# Seen Player

var player = null

func _on_vision_range_right_body_entered(body):
	if(body.name == "Player"):
		go_right = true
		locking_player(body)
	
func _on_vision_range_left_body_entered(body):
	if(body.name == "Player"):
		go_right = false
		locking_player(body)
		
func locking_player(body):
	player = body
	

# Attacking Player

func _on_attack_range_right_body_entered(body):
	if(body.name == "Player") and is_alive:
		attack(body,5)


func _on_attack_range_left_body_entered(body):
	#character.play("attack")
	if(body.name == "Player") and is_alive:
		attack(body,5)

var is_attacking = false

func attack(body,damage):
	is_attacking = true
	character.play("attack") 
	
	if body.has_method("punch_damage"):
		body.punch_damage(go_right,damage)

var is_alive = true
func player_damage():
	is_alive = false
	character.play("pass")
	
	
func _on_attack_range_right_body_exited(body):
	if body.name == "Player":
		is_attacking = false


func _on_attack_range_left_body_exited(body):
	if body.name == "Player":
		is_attacking = false




func _on_danger_area_body_entered(body):
	if(body.name == "Player") and is_alive:
		attack(body,100)
