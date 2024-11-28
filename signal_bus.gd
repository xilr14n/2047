extends Node

signal move(direcao : Vector2)
signal informa_posicoes



func move_tabuleiro(direcao: Vector2):
	move.emit()

func _informa_posicoes():
	informa_posicoes.emit()
