extends Panel

const main_menu_scene = preload("res://src/scenes/ui/main_menu.tscn")
@onready var timer: Timer = $Timer
@export var START_TIME: float = 20


func _ready():
	timer.start(START_TIME)


func _process(_delta) -> void:
	$Segundos.text = "%2d" % timer.time_left


func _on_timer_timeout():
	OS.alert("you could`t escape, time is up :(", "Game Over!")
	$"../../..".get_parent().add_child.call_deferred(main_menu_scene.instantiate())
	$"../../..".queue_free()
	await $"../../..".tree_exited
