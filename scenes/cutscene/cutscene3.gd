extends Node2D


var counter = 1
var text = [
	"'You know... kai.. people.. said destiny is written in the stars...'",
	"'Im sure.. our's is the prettiest.. brightest one..",
	"'Thats.. how.. feel.. when im.. with you..'",
	"'I hope you.. feel it too... even.. with..out.. me...'",
	"'and.. please.. take care.. of summer..'",
	"I remember what you said that day. But i tried not to.",
	"Because it is so painful when i remember you are not here anymore",
	"Yet, how can i forget you?",
	"You had the scent of roses, i tear up everytime i walk pass that flower shop",
	"The warmth of a fireplace in winter reminds me of yours",
	"You loved the stars, every night i when i look at the sky, i remember how you used to smile as you talk about constellations",
	"This baby i held in my arms resembles you.",
	"Everything reminds me of you",
	"I have to remember you",
	"I have to. In order to honor you, to treasure the time we had together.",
	"I probably will always regret that day.",
	"Forgive me, forgive my incompetent self. Just this once, please let me show you..",
	"I promise i will do my best to raise and take care of summer",
	"I will tell her stories about how amazing her mother is",
	"How despite being abandoned by the world, she never gave up into despair.",
	"She still choose to be strong, to be kind",
	"...",
	"I miss you",
	"I always will, but i will try my best to live on. For Summer too.",
	"I love you, Holly"
	]
onready var story = $story
onready var display = $display
onready var next_button = $next

func _ready():
	
	yield(get_tree().create_timer(5),"timeout")
	$opening.hide()
	
	story.text = text[0]
	display.play("one")

var next_scene = "res://scenes/Start.tscn"
onready var transition = $transition

func _on_next_pressed():
	
	if text.size() <= counter:
		transition.show()
		
		var tree = get_tree()
		yield(tree.create_timer(5),"timeout")
		tree.change_scene(next_scene)
	
	else:
		if counter == 5:
			display.play("two")
			
		elif counter == 21:
			display.play("three")
		
		story.text = text[counter]
		counter += 1
		
		if text.size() == counter:
			next_button.text = "Continue"
