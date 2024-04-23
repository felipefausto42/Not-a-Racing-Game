extends Area2D

@export var speed : int = 1000

func _physics_process(delta):
	position += transform.x * speed * delta
	

