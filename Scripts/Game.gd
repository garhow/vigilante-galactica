extends Node

##
# Signals
##

signal change_scene
signal death
signal health_changed
signal lives_changed
signal mission_changed
signal victory

##
# Classes
##

class Mission:
	var description: String
	var location: Vector2i
	func _init(desc: String, loc: Vector2i):
		description = desc
		location = loc


##
# Constants
##

const MAX_LIVES = 3
const MAX_HEALTH = 20

##
# Variables
##

var missions: Array[Mission] = [
	Mission.new("Liberate Tanusrik", Vector2i(-250, -100)),
	Mission.new("Liberate Deglazen", Vector2i(150, 100)),
	Mission.new("Complete", Vector2i.ZERO),
]

var current_mission: Mission = missions.pop_front():
	set = _set_mission

var lives: int = MAX_LIVES:
	set = _set_lives

var health: int = MAX_HEALTH:
	set = _set_health

var time: float = 0

##
# Functions
##

# Built-in functions
func _ready() -> void:
	connect("death", _on_death)
	connect("health_changed", _on_health_changed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_mission"):
		if missions.size() > 0: current_mission = missions.pop_front()

# Death
func _on_death():
	lives -= 1


# Lives
func _set_lives(value: int):
	lives = value
	emit_signal("lives_changed")


# Health
func _set_health(value: int):
	health = value
	emit_signal("health_changed", value)

func _on_health_changed(value: int):
	if value == 0:
		emit_signal("death")


# Mission
func _set_mission(value: Mission) -> void:
	current_mission = value
	emit_signal("mission_changed", value)
