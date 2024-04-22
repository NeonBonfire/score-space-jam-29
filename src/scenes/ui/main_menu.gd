extends MarginContainer

var already_running_option = false

enum OPTIONS {
	START = 0, 
	SCOREBOARD = 1, 
	CREDITS = 2, 
	QUIT = 3, 
	LENGTH
}

@onready var buttons = [
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/StartButton,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/ScoreBoardButton,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/CreditsButton,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/QuitButton
]

@onready var selectors = [
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/StartButton/HBoxContainer/Selector,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/ScoreBoardButton/HBoxContainer/Selector,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/CreditsButton/HBoxContainer/Selector,
	$CenterContainer/VBoxContainer/ButtonsBox/VBoxContainer/QuitButton/HBoxContainer/Selector
]
var selection = OPTIONS.START

func resetSelectors():
	for selector in selectors:	
		selector.text = ""

func _ready():
	setCurrentSelection(selection)

func _process(_delta):
	if Input.is_action_just_pressed("key_down"):
		selection = wrapi(selection + 1, 0, OPTIONS.LENGTH) as OPTIONS
		setCurrentSelection(selection)
	elif Input.is_action_just_pressed("key_up"):
		selection = wrapi(selection - 1, 0, OPTIONS.LENGTH) as OPTIONS
		setCurrentSelection(selection)
	elif Input.is_action_just_pressed("left_mouse"):
		handleSelection(selection)

func setCurrentSelection(_current_selection):
	resetSelectors()
	selectors[_current_selection].text = ">"

func handleSelection(_current_selection):
	if !already_running_option: 
		if _current_selection in optionsActions:
			self.call(optionsActions[_current_selection])

var optionsActions = {
	OPTIONS.START: "startGame",
	OPTIONS.SCOREBOARD: "scoreboardScene",
	OPTIONS.CREDITS: "creditsScene",
	OPTIONS.QUIT: "quitGame"
}

func startGame():
	already_running_option = true
	selectors[OPTIONS.START].text = ">"
	
	var game_start_scene = load("res://src/scenes/map/casa.tscn")
	get_parent().add_child.call_deferred(game_start_scene.instantiate())
	queue_free()

func scoreboardScene():
	already_running_option = true
	selectors[OPTIONS.SCOREBOARD].text = ">"
	var scoreboard_scene = load("res://src/scenes/ui/score_board/score_board.tscn")
	get_parent().add_child.call_deferred(scoreboard_scene.instantiate())
	queue_free()

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
				selection = i as OPTIONS
				setCurrentSelection(i)
				if event is InputEventMouseButton:
					handleSelection(selection)
				return

