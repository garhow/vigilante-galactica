class_name Player extends CharacterBody2D

##
# Enums
##

enum PlayerState {
	IDLE,
	WALK,
	SHOOT,
}

##
# Constants
##

const GRAVITY = 256.0
const GRAVITY_ACCELERATION = 4.0
const JUMP_FORCE = 400.0
const MOVEMENT_SPEED = 96.0

##
# Export variables
##

@export_category("Components")
@export var projectile: PackedScene
@export var sprite: AnimatedSprite2D

@export_category("Sound Effects")
@export var jump_sound: AudioStreamPlayer2D
@export var victory_sound: AudioStreamPlayer2D

##
# Variables
##

var flipped: bool:
	set = _set_flipped

var state: PlayerState = PlayerState.IDLE:
	set = _set_state

##
# Functions
##

func _ready() -> void:
	Game.health = Game.MAX_HEALTH
	Game.connect("victory", _on_victory)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		flipped = true
	elif event.is_action_pressed("right"):
		flipped = false
	
	if event.is_action_pressed("b"):
		_handle_combat()


func _physics_process(delta: float) -> void:
	_handle_gravity(delta)
	_handle_movement()
	_handle_states()
	move_and_slide()
	
	Game.time += delta


func _handle_combat() -> void:
	var bullet = projectile.instantiate()
	if bullet is Projectile:
		var direction: float = -1.0 if flipped else 1.0
		bullet.global_position = Vector2(global_position.x, global_position.y - 6)
		bullet.direction = direction
		get_tree().root.add_child(bullet)


func _handle_movement() -> void:
	# Handle horizontal input
	var direction = ceil(Input.get_axis("left", "right"))
	velocity.x = direction * MOVEMENT_SPEED
	
	# Handle jumping
	if is_on_floor() and Input.is_action_just_pressed("a"):
		jump_sound.play()
		velocity.y = -JUMP_FORCE


func _handle_gravity(delta: float) -> void:
	velocity.y = lerp(velocity.y, GRAVITY, GRAVITY_ACCELERATION * delta) if !is_on_floor() else 0.0


func _handle_states():
	match state:
		PlayerState.IDLE:
			if abs(velocity.x) > 0:
				state = PlayerState.WALK
		PlayerState.WALK:
			if velocity.x == 0:
				state = PlayerState.IDLE
		PlayerState.SHOOT:
			pass
		_:
			pass


func _on_victory() -> void:
	victory_sound.play()


func _set_flipped(value: bool):
	flipped = value
	sprite.flip_h = value


func _set_state(value: PlayerState):
	state = value
	match value:
		PlayerState.IDLE:
			sprite.animation = "default"
		PlayerState.WALK:
			sprite.animation = "walk"
		PlayerState.SHOOT:
			sprite.animation = "shoot"
		_:
			sprite.animation = "default"
