extends Node

class_name pipespawner

#emit signals for events 
signal crash
signal scored 
signal game_started

var pipe_scene = preload("res://scenes/pipes.tscn")
var pipe_speed = -250
var process_input = true
var started = false




#timer/timeout 
@onready var spawn_timer = $Timer


# everytime @onready timer times out, spawn a pipe
func _ready():
	pass
	





#start timer when exit idle
func start_spawning():
	if Input.is_action_just_pressed("ui_up") and process_input:
		if !started:
			spawn_timer.timeout.connect(spawn_pipe)
			spawn_timer.start()
			game_started.emit()
	if !started:
		return
	

func spawn_pipe():
	#pull in pipe scene
	var pipe = pipe_scene.instantiate() as pipes
	add_child(pipe)

	#viewport variables 
	var viewport = get_viewport()
	var half_height = viewport.size.y /2
	#spawn pipes at the end of the viewport
	pipe.position.x = viewport.size.x
	#set random range for height in viewport 
	pipe.position.y = randf_range(viewport.size.y * 0.61 - half_height, viewport.size.y * 0.99 - half_height)
	#connect pipe scene to scoring and entering functions
	pipe.entered.connect(bird_entered)
	pipe.scored.connect(point_scored)
	pipe.set_speed(pipe_speed)
	

func bird_entered():
	crash.emit()
	stop()
	
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is pipes):
		(pipe as pipes).speed = 0

		
func point_scored():
	scored.emit()
	
	

	
	
	
	
