class_name Player
extends CharacterBody2D


@export var bullet : PackedScene

var wheel_base : int = 70
var steering_angle : int = 15
var engine_power : int = 800
var friction : float = -0.9
var drag : float = -0.001
var braking : int = -450
var max_speed_reversed : int = 250
var slip_speed : int = 400
var traction_fast : float = 0.1
var traction_slow : float = 0.7
var acceleration : Vector2 = Vector2.ZERO

var steer_direction 


func enter_tree():
	set_multiplayer_authority(name.to_int())


func _process(delta):
	
	Global.player_position = position
	Global.player_speed = velocity.length()
	print_debug(name)

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()


func get_input():
#if is_multiplayer_authority():
	var turn = 0
	if Input.is_action_pressed("steer_right"):
		turn += 1
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	steer_direction = turn * deg_to_rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	
	if Input.is_action_just_pressed("shoot"):
		shoot()


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	
	if velocity.length() > slip_speed:
		traction = traction_fast
	var direction = new_heading.dot(velocity.normalized())
	
	if direction > 0:
		velocity = velocity.lerp(new_heading * velocity.length(), traction)
	if direction < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reversed)
	rotation = new_heading.angle()
	
	
func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
	
	
func shoot():
	var bullet_instance1 = bullet.instantiate()
	var bullet_instance2 = bullet.instantiate()
	owner.add_child(bullet_instance1)
	owner.add_child(bullet_instance2)
	bullet_instance1.transform = $Marker2D.global_transform
	bullet_instance2.transform = $Marker2D2.global_transform
