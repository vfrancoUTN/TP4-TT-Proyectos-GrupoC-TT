extends Control

onready var lobby = $"."
onready var conexion = $"Conexion"
onready var nombre_jugador = $"/Conexion/Nombre"
onready var label_error = $"Conexion/LabelError"
onready var jugadores = $"Jugadores"
onready var ip_ad = $"Conexion/IP"
onready var boton_crear = $"Conexion/BotonCrear"
onready var boton_unirse = $"Conexion/BotonUnirse"
onready var ventana_error = $"AcceptDialog"
onready var lista_jugadores = $"Jugadores/ItemList"
onready var boton_iniciar = $"Jugadores/BotonIniciar"

func _ready():
	Multijugador.connect("conexion_fallida", self, "_conexion_fallida")
	Multijugador.connect("conexion_exitosa", self, "_conexion_ok")
	Multijugador.connect("actualizacion_lista_jugadores", self, "actualizar_sala")
	Multijugador.connect("juego_terminado", self, "_juego_terminado")
	Multijugador.connect("error_juego", self, "_error_juego")
	#if OS.has_environment("USERNAME"):
	#	$Conexion/Nombre.text = OS.get_environment("USERNAME")
	#else:
	#	var escritorio = OS.get_system_dir(0).replace("\\", "/").split("/")
	#	$Conexion/Nombre.text = escritorio[escritorio.size() - 2]
		
func _boton_crear_presionado():
	if nombre_jugador.text == "":
		label_error.text = "Nombre de usuario no válido!"
		return
		
	conexion.hide()
	jugadores.show()
	label_error.text = ""
	
	var nom_jugador = nombre_jugador.text
	Multijugador.crear_servidor(nom_jugador)
	actualizar_sala()
	
func _boton_unirse_presionado():
	if nombre_jugador.text == "":
		label_error.text == "Nombre de usuario no válido!"
		return
		
	var ip = ip_ad.text
	if not ip.is_valid_ip_address():
		label_error.text = "Dirección IP no válida!"
		return
	
	label_error.text = ""
	boton_crear.disabled = true
	boton_unirse.disabled = true
		
	var nombre_jugador = nombre_jugador.text
	Multijugador.unirse_servidor(ip, nombre_jugador)
		
func _conexion_ok():
	conexion.hide()
	jugadores.show()
	
func _conexion_fallida():
	boton_crear.disabled = false
	boton_unirse.disabled = false
	label_error.set_text("Conexión fallida.")
	
func _juego_terminado():
	show()
	conexion.show()
	jugadores.hide()
	boton_crear.disabled = false
	boton_unirse.disabled = false
	
func _error_juego(error):
	ventana_error.dialog_text = error
	ventana_error.popup_centered_minsize()
	boton_crear.disabled = false
	boton_unirse.disabled = false
	
func actualizar_sala():
	var jugadores = Multijugador.get_lista_jugadores()
	jugadores.sort()
	lista_jugadores.clear()
	lista_jugadores.add_item(Multijugador.get_nombre_jugador() + " (Vos)")
	for j in jugadores:
		lista_jugadores.add_item(j)
		
	boton_iniciar.disabled = not get_tree().is_network_server()
	
func _boton_volver_presionado():
	get_tree().change_scene(res://Interfaz/PantallaInicio.tscn")
	
func _boton_iniciar_presionado():
	Multijugador.comenzar_juego()
	hide()
	
func _boton_ip_presionado():
	OS.shell_open("https://icanhazip.com/")
