extends Node2D

func _ready():
	get_tree().connect("network_peer_connected", self, "_jugador_conectado")

func _on_BotonHost_pressed():
	var conexion = NetworkedMultiplayerENet.new()
	conexion.create_server(6969, 2)
	get_tree().set_network_peer(conexion)


func _on_BotonUnirse_pressed():
	var conexion = NetworkedMultiplayerENet.new()
	conexion.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(conexion)

func _jugador_conectado(id):
	Globales.jugador2id = id
	var game = preload("res://Pruebas/CajaDeArenaDartsch.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
