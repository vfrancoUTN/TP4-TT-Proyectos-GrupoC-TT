extends Node

var llaves = 0
var notas = [] #las notas que vas encontrando para leerlas desde la UI
	
func getLlaves():
	return llaves
	
func setLlaves(l):
	llaves = l
	
func agregarNota(nota):
	notas.append(nota)
	
func mostratNota(indice):
	return notas[indice]
