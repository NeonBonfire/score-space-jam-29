extends Area2D

const LIMITE_ITENS_BOLSA = 3
var BOLSA = null


func _ready():
	BOLSA = get_parent().get_node("Bolsa")


func _physics_process(delta):
	if Input.is_action_just_pressed("left_mouse"):
		for coletavel in get_overlapping_areas():
			if BOLSA.get_child_count() < LIMITE_ITENS_BOLSA:
				coletavel.get_parent().remove_child(coletavel)
				coletavel.position = Vector2(-30 + (BOLSA.get_child_count() * 30), -80)
				BOLSA.add_child(coletavel)
