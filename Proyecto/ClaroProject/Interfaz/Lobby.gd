extends Control

var ip = "127.0.0.1"
var puerto = 27015
var limite_jugadores = 2

func _ready():
	get_tree().connect("network_peer_connected", self, "_jugador_conectado")

func _on_BotonHost_pressed():
	var conexion = NetworkedMultiplayerENet.new()
	conexion.create_server(puerto, limite_jugadores)
	get_tree().set_network_peer(conexion)
	print("Servidor iniciado")


func _on_BotonJoin_pressed():
	var conexion = NetworkedMultiplayerENet.new()
	conexion.create_client(ip, puerto)
	get_tree().set_network_peer(conexion)


func _on_BotonVolver_pressed():
	get_tree().change_scene("res://Interfaz/PantallaInicio.tscn")
	
func _jugador_conectado(id):
	Globales.id_jugador_2 = id
	var juego = preload("res://Pruebas/CajaDeArenaDartsch.tscn").instance()
	get_tree().get_root().add_child(juego)
	hide()
