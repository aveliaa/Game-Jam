extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

onready var animator = $AnimatedSprite
onready var agent = $agent
onready var kai = $kai


func _ready():
	
	animator.play("hitman")
	
	yield(get_tree().create_timer(5),"timeout")
	$hitman.stop()
	$bg2.show()
	
	agent.hide()
	kai.show()
	
	$papa.play()
	animator.play("papa")
	
	yield(get_tree().create_timer(5),"timeout")
	$transition.show()
	yield(get_tree().create_timer(3),"timeout")
	
	get_tree().change_scene("res://scenes/Nursery1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
