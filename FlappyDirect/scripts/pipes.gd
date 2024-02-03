extends Node2D


class_name pipes 
var speed = 0

signal entered
signal scored

func set_speed(new_speed):
	speed = new_speed
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	


func _on_top_body_entered(_body):
	entered.emit()


func _on_bottom_body_entered(_body):
	entered.emit()


func _on_scored_body_entered(_body):
	scored.emit()
