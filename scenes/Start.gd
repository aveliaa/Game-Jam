extends Node2D



onready var animator = $AnimatedSprite
func _ready():
	animator.play("hitman")


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/cutscene/intro.tscn")


func _on_Exit_pressed():
	get_tree().quit()
