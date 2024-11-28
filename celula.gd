extends Node2D
var number = 2
var color = Color(.27, .66, .33)
var color_h = 130./255.
var color_s = 60./100.
var color_v = 66./100.
var posicao_no_tabuleiro = Vector2i()
var move = Vector2()


signal victory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.move.connect(_on_move)
	SignalBus.informa_posicoes.connect(_on_informa_posicoes)
	if(randi() % 10) == 0:
		sobe_nivel()
		
	position = Vector2(posicao_no_tabuleiro) * GlobalVar.tamanho_celulas + GlobalVar.offset_celulas
	scale = float(GlobalVar.tamanho_celulas) / 100 * Vector2(1, 1)


func _process(delta: float) -> void:
	position += move * delta * GlobalVar.vel
	if $RayCast2D.is_colliding():
		colide()
	pass
	
func sobe_nivel():
	number *= 2
	$Label.text = str(number)
	aumenta_cor()
	if number == 2048:
		victory.emit()
	
func aumenta_cor():
	color_h += (15.)/255.
	color_s += 4./255.
	color_v -= .2/255.
	$Sprite2D.set("modulate", Color.from_hsv(color_h, color_s, color_v))
	#print($Sprite2D.get("modulate"))
	
func _on_move(direcao: Vector2):
	$RayCast2D.target_position = direcao * GlobalVar.tamanho_celulas
	move = direcao
	

func colide():
	var objeto_colidido = $RayCast2D.get_collider().get_parent()
	if "number" in objeto_colidido and objeto_colidido.number == number:
		posicao_no_tabuleiro = objeto_colidido.posicao_no_tabuleiro
		position = Vector2(posicao_no_tabuleiro) * GlobalVar.tamanho_celulas + GlobalVar.offset_celulas
		objeto_colidido.queue_free()
		sobe_nivel()
		move = Vector2()
		$RayCast2D.target_position /= 10
	else:
		posicao_no_tabuleiro = objeto_colidido.posicao_no_tabuleiro - Vector2i(move)
		position = Vector2(posicao_no_tabuleiro) * GlobalVar.tamanho_celulas + GlobalVar.offset_celulas
		move = Vector2()
		$RayCast2D.target_position /= 10
	
	
func __on_move(direcao: Vector2):
	$RayCast2D.target_position = direcao * GlobalVar.tamanho_tabuleiro * 10000
	$RayCast2D.force_raycast_update()
	var objeto_colidido = $RayCast2D.get_collider().get_parent()
	if "number" in objeto_colidido and objeto_colidido.number == number:
		posicao_no_tabuleiro = objeto_colidido.posicao_no_tabuleiro
		position = Vector2(posicao_no_tabuleiro) * GlobalVar.tamanho_celulas + GlobalVar.offset_celulas
		objeto_colidido.queue_free()
		sobe_nivel()
	else:
		posicao_no_tabuleiro = objeto_colidido.posicao_no_tabuleiro - Vector2i(direcao)
		position = Vector2(posicao_no_tabuleiro) * GlobalVar.tamanho_celulas + GlobalVar.offset_celulas
		
func _on_informa_posicoes():
	GlobalVar.posicoes[name] = posicao_no_tabuleiro

func _exit_tree() -> void:
	GlobalVar.posicoes.erase(name)
	#print(name, " erased from globarvar")
