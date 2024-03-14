extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
onready var camera = $Camera2D
onready var narration = $narration1
onready var display = $AnimatedSprite

func _ready():
	pass

var timer = 0.0

var scene2 = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !scene2:
		
		if camera.offset_v > -27:
		
			timer += delta
		
			if timer >= 0.1:
				camera.offset_v -= 1
				timer = 0.0
		else:
			yield(get_tree().create_timer(2),"timeout")
			activate_scene2()

onready var background = $ColorRect
func activate_scene2():
	
	
	$papa.play()
	
	scene2 = 2
	$Label.hide()
	$Label4.hide()
	
	$Label2.text = "The leave due to.."
	
	display.play("shadow")
	background.color = Color("#250707")
	
	$hitman.stop()
	yield(get_tree().create_timer(2),"timeout")
	
	display.play("papa")
	background.color = Color("#bf626d")
	
	$Label2.add_color_override("font_color", Color("#000000"))
	$Label2.text = "The leave due to.. \n \n Being a parent!"
	
	yield(get_tree().create_timer(3),"timeout")
	get_tree().change_scene("res://scenes/Nursery1.tscn")

