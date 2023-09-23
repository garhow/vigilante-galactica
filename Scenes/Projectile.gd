class_name Projectile extends Area2D

var direction: float = 1.0

@export_category("Projectile Settings")
@export var damage: int = 2
@export var speed: float = 256

@export_category("Sound Effects")
@export var fire_sound: AudioStreamPlayer2D
@export var hit_sound: AudioStreamPlayer2D

func _ready() -> void:
	connect("body_entered", _on_body_entered)
	fire_sound.play()


func _physics_process(delta: float) -> void:
	global_position.x += direction * speed * delta


func _on_body_entered(body) -> void:
	visible = false
	body.emit_signal("damaged", damage)
	await hit_sound.finished
	call_deferred("queue_free")
