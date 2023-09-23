extends Enemy

const GRAVITY = 320.0
const GRAVITY_ACCELERATION = 4.0
const MOVEMENT_SPEED = 32.0

var flipped := false:
	set = _set_flipped

@onready var target: Player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta) -> void:
	_handle_movement()
	_handle_gravity(delta)
	_handle_combat()
	move_and_slide()


func _handle_combat() -> void:
	pass


func _handle_movement() -> void:
	var target_position: Vector2 = target.global_position + -sign(global_position.direction_to(target.global_position)) * 32
	var movement_direction: Vector2 = round(global_position.direction_to(target_position) * 32)
	var direction_to_target: Vector2 = round(global_position.direction_to(target.global_position) * 32)
	flipped = true if sign(direction_to_target.x) < 0 else false
	velocity.x = sign(movement_direction.x) * MOVEMENT_SPEED


func _handle_gravity(delta: float) -> void:
	velocity.y = lerp(
		velocity.y,
		GRAVITY,
		GRAVITY_ACCELERATION * delta
	) if !is_on_floor() else 0


func _set_flipped(value: bool) -> void:
	flipped = value
	$Sprite.flip_h = value
