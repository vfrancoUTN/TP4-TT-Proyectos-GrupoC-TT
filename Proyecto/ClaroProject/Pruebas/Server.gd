extends Node2D

var conexion = NetworkedMultiplayerENet.new()
var puerto = 6969
var limite_jugadores = 2
var ip = "127.0.0.1"
#var ip = ""

func _ready():
	pass
	
func _on_BotonHost_pressed():
	iniciarServidor()
	
func _on_BotonUnirse_pressed():
	_conectar_al_servidor()
	
func iniciarServidor():
	conexion.create_server(puerto, limite_jugadores)
	get_tree().set_network_peer(conexion)
	print("Servidor Iniciado")	
	conexion.connect("peer_connected", self, "_jugador_conectado")
	conexion.connect("peer_disconnected", self, "_jugador_desconectado")
	
func _jugador_conectado(id_jugador):
	print("Jugador " + str(id_jugador) + " se ha conectado.")

func _jugador_desconectado(id_jugador):
	print("Jugador " + str(id_jugador) + " se ha desconectado")
	
func _conectar_al_servidor():
	conexion.create_client(ip, puerto)
	get_tree().set_network_peer(conexion)
	conexion.connect("connection_failed", self, "_conexion_fallida")
	conexion.connect("connection_succeeded", self, "_conexion_exitosa")
	
func _conexion_fallida():
	print("La conexión al servidor ha fallado")
	
func _conexion_exitosa():
	print("Conexión realizada con éxito")
