class_name Planet extends Area2D

## The scene that the planet would take you to.
@export var planet_scene: PackedScene

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body: PhysicsBody2D) -> void:
	body.destination = Spaceship.Destination.new(name, planet_scene)

func _on_body_exited(body: PhysicsBody2D) -> void:
	body.destination = null
