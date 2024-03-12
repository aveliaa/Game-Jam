extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
onready var player = $Player/Player
onready var target = $MainTarget/EnermyBeginner

onready var died = $Player/Player/popupLost
onready var win = $Player/Player/popupWin

func _process(delta):
	
	if player.remaining_hp < 0:
		died.show()
		
	elif !target.is_alive:
		yield(get_tree().create_timer(2),"timeout")
		win.show()

func _on_restart_pressed():
	get_tree().change_scene("res://scenes/Level 1.tscn")

func _on_nextLevel_pressed():
	get_tree().change_scene("res://scenes/Level2Transition.tscn")
