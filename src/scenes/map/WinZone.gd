extends Area2D


func _on_body_entered(body):
	var scoreboard_scene = load("res://src/scenes/ui/whats_your_name.tscn")
	$"..".get_parent().add_child.call_deferred(scoreboard_scene.instantiate())
	$"..".queue_free()
	await $"..".tree_exited
