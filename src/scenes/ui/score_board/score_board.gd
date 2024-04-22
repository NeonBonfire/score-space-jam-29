extends Control

const main_menu_scene = preload("res://src/scenes/ui/main_menu.tscn")
const FILE_PATH = "res://data/save_game.csv"
@onready var VARIAVEIS_GLOBAIS = get_node("/root/VariaveisGlobais")
@onready var DEFAULT_ROW = $VBoxContainer/DefaultRow
@onready var VBOX = $VBoxContainer


func _ready():
	var scores = loadSave()
	scores.sort_custom(custom_array_sort)
	for i in scores.size():
		var newRow = DEFAULT_ROW.duplicate()
		newRow.get_node("Rank").text = str(i+1) + "."
		newRow.get_node("Nome").text = scores[i][0]
		newRow.get_node("Pontos").text = scores[i][1]
		newRow.visible = true
		VBOX.add_child(newRow)


func custom_array_sort(a, b) -> bool:
	return a[1] > b[1]


func loadSave():
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	
	var result = Array()
	if file != null:
		while !file.eof_reached():
			var content: Array = file.get_csv_line()
			if !String(content[0]).is_empty():
				result.append(content)
		file.close()
	return result


func writeSave(save: Array):
	var scores = loadSave()
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	for line: Array in scores:
			file.store_csv_line(line)
	file.store_csv_line(save)
	file.close()


func _on_button_pressed():
	get_parent().add_child.call_deferred(main_menu_scene.instantiate())
	queue_free()
	await tree_exited
