extends Node2D

var counter = 1
var next_display = 4
var text = [
	"When it happened, i had just gotten home from a mission. i had a bad feeling so i went to your house.",
	"It's the first time i genuinely felt fear strike my body.",
	"The next thing i knew, i rushed inside",
	"I still shudder when i remember how i found you in that house.",
	"You passed out on the floor, hugging Summer.",
	"'It is so hard to breathe in here' 'Summer must feel so scared' 'It is scalding hot, are they two hurt?'",
	"I hated myself for not saving you sooner.",
	"Even to this day, i still keep feeling the regret i felt that day, even more so.",
	"All that training as a hitman, meaningless.",
	"I can not even save the one who matters the most",
	"I felt the heat of the blaze around me, yet you were so cold"
	]
onready var story = $story
onready var display = $display
onready var next_button = $next

func _ready():
	
	yield(get_tree().create_timer(5),"timeout")
	$opening.hide()
	
	story.text = text[0]
	display.play("one")

var next_scene = "res://scenes/Nursery3.tscn"
onready var transition = $transition

func _on_next_pressed():
	
	if text.size() <= counter:
		transition.show()
		
		var tree = get_tree()
		yield(tree.create_timer(5),"timeout")
		tree.change_scene(next_scene)
	
	else:
		if counter == next_display:
			display.play("two")
		
		story.text = text[counter]
		counter += 1
		
		if text.size() == counter:
			next_button.text = "Continue"
