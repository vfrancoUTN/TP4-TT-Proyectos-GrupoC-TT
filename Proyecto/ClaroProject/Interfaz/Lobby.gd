extends Node

var conexion = NetworkedMultiplayerENet.new()
var puerto = 6969
var limite_jugadores = 2
var ip = "127.0.0.1"

func _ready():
	pass
	
func _on_BotonHost_pressed():
	_iniciar_servidor()

func _on_BotonUnirse_pressed():
	_unirse_servidor()
	
func _iniciar_servidor():
	conexion.create_server(puerto, limite_jugadores)
	get_tree().set_network_peer(conexion)
	print("Servidor iniciado IP y puerto: " + ip + ":" + puerto)
	conexion.connect("peer_connected", self, "_jugador_conectado")
	conexion.connect("peer_disconnected", "_jugador_desconectado")
	
func _jugador_conectado(id):
	print("Jugador " + id + " se ha conectado al servidor.")

func _jugador_desconectado(id):
	print("Jugador " + id + " se ha desconectado del servidor.")
	
func _unirse_servidor():
	conexion.create_client(ip, puerto)
	get_tree().set_network_peer(conexion)
	conexion.connect("connection_failed", self, "_conexion_fallida")
	conexion.connect("connection_succeeded", self, "_conexion_exitosa")

func _conexion_fallida():
	print("Error al unirse al servidor")

func _conexion_exitosa():
	print("Conexión al servidor exitosa.")
