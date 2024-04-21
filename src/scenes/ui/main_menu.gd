extends MarginContainer

const game_start_scene = preload("res://src/scenes/map/casa.tscn")

enum OPTIONS {
	START = 0, 
	OPTIONS = 1, 
	CREDITS = 2, 
	QUIT = 3 
}

@onready var selectors = []
var selection = OPTIONS.START

func startUpSelectors():
	var buttonNames = ["StartButton", "OptionsButton", "CreditsButton", "QuitButton"]
	var basePath = "MainMenu/CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/"
	var suffix = "Selector"
	for buttonName in buttonNames:
		var selector = get_node_or_null(basePath + buttonName +  suffix)
		if selector:
			selectors.append(selector)
		else:
			print("Selector not found: " + basePath + buttonName + suffix)

func resetSelectors():
	for selector in selectors:
		selector.text = ""

func _ready():
	startUpSelectors()
	setCurrentSelection(selection)

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and selection < OPTIONS.QUIT:
		selection += 1
		setCurrentSelection(selection)
	elif Input.is_action_just_pressed("ui_up") and selection > OPTIONS.START:
		selection -= 1
		setCurrentSelection(selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handleSelection(selection)

func setCurrentSelection(_current_selection):
	resetSelectors()
	if _current_selection in optionsActions:
		self.call(optionsActions[_current_selection])

func handleSelection(_current_selection):
	if _current_selection in optionsActions:
		self.call(optionsActions[_current_selection])

var optionsActions = {
	OPTIONS.START: "startGame",
	OPTIONS.OPTIONS: "optionsScene",
	OPTIONS.CREDITS: "creditsScene",
	OPTIONS.QUIT: "quitGame"
}

func startGame():
	selectors[OPTIONS.START].text = ">"
	get_parent().add_child(game_start_scene.instance())
	queue_free()

func optionsScene():
	print("TODO: add options scene")

func creditsScene():
	print("TODO: add credits scene")

func quitGame():
	get_tree().quit()
