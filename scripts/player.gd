extends CharacterBody2D

const TILE_SIZE = 16
const MOVE_SPEED = 8  # Tiles per second

var target_position = Vector2.ZERO
var is_moving = false

func _ready():
	target_position = position

func _physics_process(delta):
	if not is_moving:
		handle_input()
	else:
		move_to_target(delta)

func handle_input():
	var move_direction = Vector2.ZERO

	if Input.is_action_just_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		move_direction = Vector2.UP
		
	elif Input.is_action_just_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		move_direction = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		move_direction = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		move_direction = Vector2.RIGHT

	if move_direction != Vector2.ZERO:
		var potential_target = position + move_direction * TILE_SIZE
		if can_move_to(potential_target):
			target_position = potential_target
			is_moving = true

func move_to_target(delta):
	var move_distance = MOVE_SPEED * TILE_SIZE * delta
	var distance_to_target = position.distance_to(target_position)

	if distance_to_target > move_distance:
		velocity = position.direction_to(target_position) * MOVE_SPEED * TILE_SIZE
	else:
		velocity = position.direction_to(target_position) * (distance_to_target / delta)
		is_moving = false

	move_and_slide()

func can_move_to(pos):
	# Test move
	var collision = move_and_collide(pos - position, true, true, true)
	return collision == null
