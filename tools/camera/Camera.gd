extends Camera2D

 

@export var smooth = 2
@export var clampX = 1568
@export var originX = 0
@export var originY = 0
@export var clampY = 1032 


@onready var player : CharacterBody2D = get_parent().get_node("Player")


func _process(delta):
	player = get_parent().get_node("Player")
	
	#position.x = clamp(position.x, 120, 1568)
	#position.y = clamp(position.x, 16, 1032)

	#position = Global.player_position

	position.x =player.transform.origin.x
	position.x = clamp(position.x, originX, clampX)
	position.y = player.transform.origin.y
	position.y = clamp(position.y, originY, clampY)
