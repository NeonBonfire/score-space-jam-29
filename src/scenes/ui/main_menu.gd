extends MarginContainer

const game_start_scene = preload("res://src/scenes/map/casa.tscn")

enum OPTIONS {
	START = 0, 
	OPTIONS = 1, 
	CREDITS = 2, 
	QUIT = 3, 
	LENGTH
}

@onready var buttons = [
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/StartButton,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/OptionsButton,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/CreditsButton,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/QuitButton
]

@onready var selectors = [
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/StartButton/HBoxContainer/Selector,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/OptionsButton/HBoxContainer/Selector,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/CreditsButton/HBoxContainer/Selector,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/QuitButton/HBoxContainer/Selector
]
var selection = OPTIONS.START

func resetSelectors():
	for selector in selectors:	
		selector.text = ""

func _ready():
	setCurrentSelection(selection)

func _process(delta):
	if Input.is_action_just_pressed("key_down"):
		selection = wrapi(selection + 1, 0, OPTIONS.LENGTH)
		setCurrentSelection(selection)
	elif Input.is_action_just_pressed("key_up"):
		selection = wrapi(selection - 1, 0, OPTIONS.LENGTH)
		setCurrentSelection(selection)
	elif Input.is_action_just_pressed("left_mouse"):
		handleSelection(selection)

func setCurrentSelection(_current_selection):
	resetSelectors()
	selectors[_current_selection].text = ">"

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
	print("skipping it rightaway")
	get_parent().add_child.call_deferred(game_start_scene.instantiate())
	queue_free()

func optionsScene():
	print("TODO: add options scene")

func creditsScene():
	print("TODO: add credits scene")

func quitGame():
	get_tree().quit()
	

func _input(event):
	var is_mouse_motion = event is InputEventMouseMotion
	var is_left_mouse_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed
	
	if is_mouse_motion or is_left_mouse_click:
		for i in range(buttons.size()):
			var button = buttons[i]
			var rect = button.get_global_rect()
			if rect.has_point(event.position):
				selection = i
				setCurrentSelection(i)
				if event is InputEventMouseButton:
					handleSelection(i)
				return

