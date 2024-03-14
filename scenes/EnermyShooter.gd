extends KinematicBody2D

export (int) var speed = 0.5
export (int) var GRAVITY = 1200
export (int) var jump_speed = -400
export (int) var power

onready var character = $character

const UP = Vector2(0,-1)

var velocity = Vector2()

var timer = 0.0
export (float) var gun_speed

func _ready():
	if is_alive:
		walk(false)
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if is_alive:
		
		if is_attacking and player:
			timer += delta
			if timer >= gun_speed:
				player.shoot_damage(power)
				timer = 0.0
		
		else:
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
	if !is_attacking and is_alive:
		character.play("run")
	
func walk(direction):
	if is_alive:
		character.flip_h = direction
		character.play("walk")

func in_limit(direction_right):
		character.play("default")
		yield(get_tree().create_timer(2),"timeout")
		walk(!direction_right)
		go_right = direction_right

var player = null
	
func locking_player(body):
	#First time?
	if !player:
		$sign/notice.show()
		$notice.play()
		
	player = body


var is_attacking = false

func attack(body,damage):
	is_attacking = true
	character.play("attack") 
	$shoot.play()
	
	# if in danger zone
	if body.has_method("punch_damage") and damage == 100:
		body.punch_damage(go_right,damage)

var is_alive = true

func player_damage():
	is_alive = false
	$shoot.stop()
	$sign/notice.hide()
	$sign/Sprite.hide()
	character.play("pass")

func _on_patrol_left_body_entered(body):
	if body.name == self.name and player == null:
		in_limit(true)

func _on_patrol_right_body_entered(body):
	if body.name == self.name and player == null:
		in_limit(false)

func _on_vision_range_right_body_entered(body):
	if(body.name == "Player"):
		go_right = true
		locking_player(body)

func _on_vision_range_left_body_entered(body):
	if(body.name == "Player"):
		go_right = false
		locking_player(body)


func _on_attack_range_right_body_entered(body):
	if(body.name == "Player") and is_alive:
		attack(body,power)

func _on_attack_range_right_body_exited(body):
	if body.name == "Player":
		is_attacking = false
		$shoot.stop()

func _on_attack_range_left_body_entered(body):
	if(body.name == "Player") and is_alive:
		attack(body,power)

func _on_attack_range_left_body_exited(body):
	if body.name == "Player":
		is_attacking = false
		$shoot.stop()
		
func _on_danger_area_body_entered(body):
	if(body.name == "Player") and is_alive:
		attack(body,100)




