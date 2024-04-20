extends CharacterBody2D


const SPEED = 300.0


func _physics_process(_delta):
	var direction = Input.get_vector("key_left", "key_right", "key_up", "key_down")
	velocity = direction * SPEED
	
	look_at(get_global_mouse_position())
	
	move_and_slide()
