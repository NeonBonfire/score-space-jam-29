extends Panel

@onready
var timer: Timer = $Timer

@export
var START_TIME: int = 30


func _ready():
	timer.start(START_TIME)
	print(timer.time_left)

func _process(delta) -> void:
	$Segundos.text = "%2d" % timer.time_left
