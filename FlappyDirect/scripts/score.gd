extends Control

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true
	
func update_score():
	$Label.text = "Score:" + str(score)
	
	
