# This script controls the sprite for the Spaceship.

extends Sprite2D

@onready var spaceship: Spaceship = get_parent()

func _ready() -> void:
	spaceship.connect("travel", _on_travel)
	
	scale = Vector2.ZERO
	_scale_sprite(Vector2.ONE)


func _physics_process(_delta) -> void:
	_rotate_sprite()


func _on_travel() -> void:
	_scale_sprite(Vector2.ZERO)


func _rotate_sprite() -> void:
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", deg_to_rad(spaceship.velocity.x / 3), 0.1)


func _scale_sprite(value: Vector2) -> void:
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "scale", value, 0.8)
