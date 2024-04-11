extends Area2D

var speed : int = 800

func _physics_process(delta):
	position += transform.x * speed * delta
	

