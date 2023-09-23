class_name Enemy extends CharacterBody2D

signal damaged

@export var health: int = 20:
	set = _set_health

func _ready() -> void:
	connect("damaged", _on_damaged)


func _set_health(value: int) -> void:
	health = value
	if health <= 0:
		call_deferred("queue_free")


func _on_damaged(damage: int) -> void:
	print("WHAT")
	health -= damage
