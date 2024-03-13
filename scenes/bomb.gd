extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

onready var animator = $animator
onready var sfx = $sfx

var active = true

func _on_bombArea_body_entered(body):
	if(body.name == "Player") and active:
		
		active = false
		animator.play("default")
		sfx.play()
		body.shoot_damage(50)
