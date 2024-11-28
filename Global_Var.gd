extends Node

var tamanho_tabuleiro = 100
var tamanho_celulas = 128
var offset_celulas = Vector2(64, 64)
var posicoes = Dictionary()
const vel = 200

func get_posicoes():
	SignalBus.informa_posicoes.emit()
	return posicoes.values()
