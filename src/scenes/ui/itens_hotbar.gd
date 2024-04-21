extends Control


@onready var HBOX = $hBox


func adicionarItem(coletavel: Area2D):
	var novoItem = TextureRect.new()
	novoItem.texture = coletavel.get_node("Sprite2D").texture
	HBOX.add_child(novoItem)


func adicionarItemBlank():
	var novoItem = TextureRect.new()
	novoItem.texture = load("res://src/assets/rato.png")
	HBOX.add_child(novoItem)


func _on_coletavel_handler_bolsa_atualizada(bolsa):
	for item in HBOX.get_children():
		item.queue_free()
	for item in bolsa.get_children():
		adicionarItem(item)
	for n in range(3 - bolsa.get_child_count()):
		adicionarItemBlank()
