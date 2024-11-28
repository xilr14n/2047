extends Node2D

#var celula = preload("res://celula.tscn").instantiate()
#var parede = preload("res://parede.tscn").instantiate()

var altura_tabuleiro = 4
var largura_tabuleiro = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var item
	for linha in (altura_tabuleiro + 2):
		for coluna in (largura_tabuleiro + 2):
			if coluna == 0 or coluna == largura_tabuleiro + 1 or linha == 0 or linha == largura_tabuleiro + 1:
				item = load("res://parede.tscn").instantiate()
				item.posicao_no_tabuleiro = Vector2i(linha - 1, coluna - 1)
				add_child(item)
	item = load("res://celula.tscn").instantiate()
	item.posicao_no_tabuleiro = Vector2i(randi()%largura_tabuleiro, randi()%altura_tabuleiro)
	add_child(item)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("down"):
		SignalBus.move.emit(Vector2(0,1))
		spawn()
	if Input.is_action_just_pressed("up"):
		SignalBus.move.emit(Vector2(0,-1))
		spawn()
	if Input.is_action_just_pressed("left"):
		SignalBus.move.emit(Vector2(-1,0))
		spawn()
	if Input.is_action_just_pressed("right"):
		SignalBus.move.emit(Vector2(1,0))
		spawn()
	pass


func spawn():
	var item = load("res://celula.tscn").instantiate()
	var pos_sugerida
	while (not item.is_inside_tree()):
		pos_sugerida = Vector2i(randi()%largura_tabuleiro, randi()%altura_tabuleiro)
		#print(pos_sugerida)
		if not pos_sugerida in GlobalVar.get_posicoes():
			item.posicao_no_tabuleiro = pos_sugerida
			add_child(item)
