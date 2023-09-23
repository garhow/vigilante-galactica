extends Node2D

const RANGE = 100

var point: Vector2i = Game.current_mission.location

@export var sprite: Sprite2D

func _ready() -> void:
	Game.connect("mission_changed", _on_mission_changed)

func _physics_process(_delta):
	visible = false if global_position.distance_to(point) < RANGE or point == Vector2i.ZERO else true
	rotation = global_position.angle_to_point(point)
	scale = sprite.scale

func _on_mission_changed(mission: Game.Mission) -> void:
	point = mission.location
