extends CharacterBody2D

class_name player

signal game_started

const flap_force = -300
const max_speed = 600

var gravity = 850
var rotation_speed = 3

var started = false
var process_input = true

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up") and process_input:
		if !started:
			$AnimatedSprite2D.play("fly")
			game_started.emit()
			started = true
		jump()
	if !started:
		return
	
	#falling
	velocity.y += gravity * delta 
	
	#speed limit
	if velocity.y > max_speed:
		velocity.y = max_speed-10
	
	move_and_collide(velocity * delta)
	tilt()
	
	
func tilt():
	if velocity.y  > 0 and rad_to_deg(rotation) < 90:
			rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 and rad_to_deg(rotation) > -30:
			rotation -= rotation_speed * deg_to_rad(1)
	
	
func done():
	process_input = false

func stop():
	$AnimatedSprite2D.stop()
	gravity = 0
	velocity = Vector2.ZERO		
	
		
		
		
func jump():
	velocity.y = flap_force
	rotation = deg_to_rad(-30)
	
