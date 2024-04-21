extends Area2D

signal bolsa_atualizada(bolsa: Node2D)

const LIMITE_ITENS_BOLSA = 3

@onready var BOLSA: Node2D = get_parent().get_node("Bolsa")


func _ready():
	bolsa_atualizada.emit(BOLSA)


func _physics_process(_delta):
	if Input.is_action_just_pressed("left_mouse"):
		for coletavel in get_overlapping_areas():
			if BOLSA.get_child_count() < LIMITE_ITENS_BOLSA:
				coletavel.get_parent().remove_child(coletavel)
				adicionar_item_bolsa(coletavel)


func adicionar_item_bolsa(coletavel: Node2D):
	BOLSA.add_child(coletavel)
	bolsa_atualizada.emit(BOLSA)


func limpar_bolsa():
	for item in BOLSA.get_children():
		item.queue_free()
		await item.tree_exited
		bolsa_atualizada.emit(BOLSA)


func _on_entrega_carro_handler_pontuacao_calculada(pontos):
	limpar_bolsa()
