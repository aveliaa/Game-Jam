extends Node2D


onready var player = $Player
onready var target = $Boss/MainSoldier

onready var died = $Player/popupLost
onready var win = $Player/popupWin


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.remaining_hp < 0:
		died.show()
		
	elif !target.is_alive:
		yield(get_tree().create_timer(2),"timeout")
		win.show()


func _on_MainRestart_pressed():
	get_tree().change_scene("res://scenes/Level3.tscn")


func _on_nextLevel_pressed():
	get_tree().change_scene("res://scenes/cutscene/cutscene3.tscn")


func _on_restart_pressed():
	get_tree().change_scene("res://scenes/Level3.tscn")


func _on_ResetDay_pressed():
	get_tree().change_scene("res://scenes/Nursery3.tscn")
