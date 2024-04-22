extends Control


const FILE_PATH = "res://data/save_game.csv"
@onready var DEFAULT_ROW = $VBoxContainer/DefaultRow
@onready var VBOX = $VBoxContainer


func _ready():
	var scores = loadSave()
	scores.sort_custom(custom_array_sort)
	print(scores)
	for i in scores.size():
		var newRow = DEFAULT_ROW.duplicate()
		newRow.get_node("Rank").text = str(i) + "."
		newRow.get_node("Nome").text = scores[i][0]
		newRow.get_node("Pontos").text = scores[i][1]
		newRow.visible = true
		VBOX.add_child(newRow)


func custom_array_sort(a, b) -> bool:
	return a[1] > b[1]


func loadSave():
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	
	var result = Array()
	while !file.eof_reached():
		var content: Array = file.get_csv_line()
		if !String(content[0]).is_empty():
			result.append(content)
	file.close()
	return result


func writeSave(save):
	var scores = loadSave()
	var file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
	for line: Array in scores:
			file.store_csv_line(line)
	file.store_csv_line(save)
	file.close()
