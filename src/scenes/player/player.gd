extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):
	var direction = Input.get_vector("key_left", "key_right", "key_up", "key_down")
	velocity = direction * SPEED
	
	rotate_player_to_mouse()
	
	move_and_slide()


func rotate_player_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	var direction = (mouse_position - position).normalized()
	var new_angle =  PI + atan2(direction.y, direction.x) 
	rotation = new_angle
