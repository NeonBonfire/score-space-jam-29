extends Area2D

signal bolsa_atualizada(bolsa: Node2D)
const LIMITE_ITENS_BOLSA = 10

@onready var VARIAVEIS_GLOBAIS = get_node("/root/VariaveisGlobais")
@onready var BOLSA: Node2D = $"../Bolsa"
@onready var PONTUACAO_LABEL: Label = $"../EntregaCarroHandler/Pontuacao/Control/Panel/Label"

@onready var ITENS: Dictionary = {
	"res://src/scenes/coletaveis/carteira.tscn": 40,
	"res://src/scenes/coletaveis/colar.tscn": 70,
	"res://src/scenes/coletaveis/saco_de_ouro.tscn": 150,
	"res://src/scenes/coletaveis/queijo.tscn": 210,
}

var pontosTotais = 0

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
	adiciona_pontos(ITENS[coletavel.scene_file_path])
	bolsa_atualizada.emit(BOLSA)


func limpar_bolsa():
	for item in BOLSA.get_children():
		item.queue_free()
		await item.tree_exited
		bolsa_atualizada.emit(BOLSA)


func adiciona_pontos(pontos):
	pontosTotais += pontos
	PONTUACAO_LABEL.text = str(pontosTotais)
	VARIAVEIS_GLOBAIS.pontos = pontosTotais
