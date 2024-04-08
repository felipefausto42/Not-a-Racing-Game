class_name Player
extends CharacterBody2D


var wheel_base : int = 64  # Distâncias das todas traseiras às dianteiras
var steering_angle : float = 30  # Ângulo de curva dos pneus dianteiros
var engine_power : int = 800
var steer_direction : float
var acceleration : Vector2 = Vector2.ZERO
var friction : float = -9
var drag : float = -0.001

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	
func get_input():
	var turn = 0
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	if Input.is_action_pressed("steer_right"):
		turn += 1
		
	steer_direction = turn * deg_to_rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	
	
func calculate_steering(delta):
	# Localização das rodas
	var rear_wheel = position - transform.x * wheel_base/2
	var front_wheel = position + transform.x * wheel_base/2

	# Posicionamento das rodas em relação ao mapa
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta

	var new_heading = (front_wheel - rear_wheel).normalized()
	
	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()


func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
