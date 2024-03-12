extends Node2D

# itung performance dari berapa kali salah, dari situ kasi penalty
# summer kasi 3 request (randomized)

var current_request = 0

onready var summer_anim = $summer/SummerAnim

# Called when the node enters the scene tree for the first time.
func _ready():
	current_request = generate_request()
	

var time = 0
var energy = 5
onready var time_label = $Labels/time
onready var energy_label = $Labels/energy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	get_input()
	
	time = int(timer.time_left)
	time_label.text = str(time)
	
	# If task is still running
	if(current_request != null):
		if(time == 0):
			current_request = generate_request()
			energy -= 1
			
			energy_label.text = str(energy)
			
			# TODO: When energy == 0 / task udah 5 kali selesai, go to next scene
			# jangan lupa transfer energi, 5 x 20
			
		elif time == 3:
			summer_cry()
	

var current_task = 0
var current_obj = null
onready var holding = $kai/hold

func get_input():
	if Input.is_action_just_pressed("enter") and current_area != 0:
		if current_area == 5 and current_obj != null:
			handle_request()
		else:
			current_task = current_area
			$kai/pickUp.play()
			current_obj = get_object(current_task)
			
			if(current_obj != null):
				holding.show()
				holding.texture = load(current_obj)
				
func get_object(input):
	if input == 1:
		return "res://assets/nursery/milk.png"
	elif input == 2:
		return "res://assets/nursery/onesie.png"
	elif input == 3:
		return "res://assets/nursery/nappy.png"
	elif input == 4:
		return "res://assets/nursery/open-book.png"
	else:
		return null
		
# - - - requesting - - -
# 1 -> give milk
# 2 -> change clothes
# 3 -> change diaper
# 4 -> read story

var randomizer = RandomNumberGenerator.new()
onready var summer_request = $summer/want/objective

func generate_request():
	timer.start(6)
	summer_default()
	current_obj = null
	
	var task = randomizer.randi_range(1,4)
	summer_request.texture = load(get_object(task))
	
	return task

# - - - timer - - -
onready var timer = $Timer

# - - - handle request - - -
func handle_request():
	holding.hide()
	
	
	if current_task != current_request:
		summer_cry()
		$"summer/false-effect".play()
		
	else:
		current_request = null
		summer_happy()
		$"summer/true-effect".play()
		
		yield(get_tree().create_timer(3),"timeout")
		
		current_request = generate_request()

onready var summer_sound = $summer/sound
# - - - summer animation - - - 
func summer_default():
	summer_anim.play("default")

func summer_cry():
	summer_sound.stream = load("res://assets/sound/nursery/grumpy-crying-baby-4-18815.mp3")
	summer_sound.play()
	#yield(get_tree().create_timer(3),"timeout")
	summer_anim.play("cry")

func summer_happy():
	summer_sound.stream = load("res://assets/sound/nursery/086333_toddler-laughingmp3-81705.mp3")
	summer_sound.play()
	summer_anim.play("happy")


# - - - Area Navigation - - -

var current_area = 0

func set_area(code,body):
	if(body.name == "kai"): 
		current_area = code

# Table
func _on_milkArea_body_entered(body):
	set_area(1,body)

# Dresser
func _on_dressArea_body_entered(body):
	set_area(2,body)

# Changing Table
func _on_diaperArea_body_entered(body):
	set_area(3,body)

# Bookshelf
func _on_bookArea_body_entered(body):
	set_area(4,body)

# Bassinet
func _on_bassinetArea_body_entered(body):
	set_area(5,body)

