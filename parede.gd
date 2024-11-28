extends Node2D
var posicao_no_tabuleiro = Vector2i()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(posicao_no_tabuleiro) * GlobalVar.tamanho_celulas + GlobalVar.offset_celulas
	scale = float(GlobalVar.tamanho_celulas) / 200 * Vector2(1, 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
