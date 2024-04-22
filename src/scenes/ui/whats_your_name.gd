extends Control


@onready var VARIAVEIS_GLOBAIS = get_node("/root/VariaveisGlobais")
@onready var input_text = $VBoxContainer/HBoxContainer/LineEdit


func _on_button_pressed():
	VARIAVEIS_GLOBAIS.nome_usuario = input_text.text
	scoreboardScene()


func scoreboardScene():
	var scoreboard_scene = load("res://src/scenes/ui/score_board/score_board.tscn")
	
	var scoreboard_instancia = scoreboard_scene.instantiate()
	scoreboard_instancia.writeSave([VARIAVEIS_GLOBAIS.nome_usuario, VARIAVEIS_GLOBAIS.pontos])
	
	get_parent().add_child.call_deferred(scoreboard_instancia)
	queue_free()
	await tree_exited
