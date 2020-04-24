extends Camera2D

const MOVE_SPEED = 500

func _process(delta):
	# Movement
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		global_position += Vector2.UP * delta * MOVE_SPEED
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		global_position += Vector2.LEFT * delta * MOVE_SPEED
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		global_position += Vector2.DOWN * delta * MOVE_SPEED
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		global_position += Vector2.RIGHT * delta * MOVE_SPEED
