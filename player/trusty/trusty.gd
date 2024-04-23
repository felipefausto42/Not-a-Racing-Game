class_name Trusty
extends Player

@onready var spritesheet : Sprite2D = $Sprite2D
@export var bullet : PackedScene


func _process(delta):
	spritesheet.frame = 1
	

func _physics_process(delta):
	acceleration = Vector2.ZERO
	shoot()
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()

func shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet_instance1 = bullet.instantiate()
		var bullet_instance2 = bullet.instantiate()
		owner.add_child(bullet_instance1) # Owner referencia o nó raiz
		owner.add_child(bullet_instance2)
		bullet_instance1.transform = $Marker2D.global_transform
		bullet_instance2.transform = $Marker2D2.global_transform
