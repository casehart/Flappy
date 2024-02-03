extends Node


enum GameState {IDLE, RUNNING, ENDED}

var game_state

@onready var pipe_spawner = $"../pipespawner" as pipespawner
@onready var bird = $"../bird" as player 
@onready var game_manager = $"."



var points = 0
 

func _ready():
	game_state = GameState.IDLE
	bird.game_started.connect(game_started)
	pipe_spawner.crash.connect(end_game)
	
	pipe_spawner.scored.connect(point_scored)
	
func game_started():
	game_state = GameState.RUNNING
	pipe_spawner.start_spawning()
	
	
func end_game():
	bird.done()
	pipe_spawner.stop()
	
func point_scored():
	points += 1
	print(points)
	
