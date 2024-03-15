extends Node2D



onready var animator = $AnimatedSprite
func _ready():
	animator.play("hitman")


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/cutscene/intro.tscn")


func _on_Exit_pressed():
	get_tree().quit()


onready var how_to_play = $HowToPlay

func _on_close_pressed():
	how_to_play.hide()


func _on_Tutorial_pressed():
	how_to_play.show()
