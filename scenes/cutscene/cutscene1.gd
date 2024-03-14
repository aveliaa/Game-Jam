extends Node2D

var counter = 1
var next_display = 3
var text = [
	"I had an unlucky mission. i probably would've been dead if i had not landed on that garbage pile.",
	"That time, i already felt myself fading. I thought 'this is it. It is my fate to die in an alleyway. On top of a pile of garbage'.",
	"But then, you showed up.",
	"You treated some shady stranger you do not even know. No questions asked.",
	"Perhaps i had a minor concussion that day. I became vulnerable.",
	"I was touched by your kindness, i opened up to you.",
	"Surprisingly we had a lot in common, in a way.",
	"Like how I never know the name of my parents, whether they are alive or dead. They just up and left.",
	"And how yours abandoned you too when they found out you were with child.",
	"From that day onward, we formed some kind of friendship. I'd often drop by to see you after work.",
	"We became so close i accompanied you when you were in labor. You said that i'm your only family."
	]
onready var story = $story
onready var display = $display
onready var next_button = $next

func _ready():
	
	yield(get_tree().create_timer(5),"timeout")
	$opening.hide()
	
	story.text = text[0]
	display.play("one")

var next_scene = "res://scenes/Nursery2.tscn"
onready var transition = $transition

func _on_next_pressed():
	
	if text.size() <= counter:
		transition.show()
		
		var tree = get_tree()
		yield(tree.create_timer(3),"timeout")
		tree.change_scene(next_scene)
	
	else:
		if counter == next_display:
			display.play("two")
		
		story.text = text[counter]
		counter += 1
		
		if text.size() == counter:
			next_button.text = "Continue"
	
