extends Node2D


onready var player = $Player
onready var target = $MainTarget/Boss

onready var died = $Player/popupLost
onready var win = $Player/popupWin

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.remaining_hp < 0:
		died.show()
		
		
	elif !target.is_alive:
		yield(get_tree().create_timer(2),"timeout")
		win.show()


func _on_MainRestart_pressed():
	get_tree().change_scene("res://scenes/Level2.tscn")


func _on_restart_pressed():
	get_tree().change_scene("res://scenes/Level2.tscn")


func _on_nextLevel_pressed():
	get_tree().change_scene("res://scenes/cutscene/cutscene2.tscn")
