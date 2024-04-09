extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene


func _on_host_pressed():
	peer.create_server(5040)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player() # Adicionar o host
	

func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	$VBoxContainer/ID.text = player.name


func _on_join_pressed():
	peer.create_client("localhost", 5040)
	multiplayer.multiplayer_peer = peer
