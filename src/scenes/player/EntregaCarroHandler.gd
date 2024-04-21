extends Area2D

signal pontuacao_calculada(pontos: int)


@onready var BOLSA: Node2D = get_parent().get_node("Bolsa")


func _process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		if get_overlapping_areas().size():
			var pontos_locais: int = 0
			for item in BOLSA.get_children():
				pontos_locais += adiciona_pontuacao(item)
			pontuacao_calculada.emit(pontos_locais)


func adiciona_pontuacao(item) -> float:
	print("...TODO: pontuacao calc...")
	return 0
