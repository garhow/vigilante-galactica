class_name Spaceship extends CharacterBody2D

##
# Classes
##

## Represents a destination for the spaceship to travel to.
class Destination:
	var name: String
	var scene: PackedScene
	
	func _init(arg1: StringName, arg2: PackedScene):
		name = str(arg1)
		scene = arg2

##
# Signals
##

## Emits when the spaceship travels to a planet.
signal travel

##
# Constants
##

## The speed of the spaceship.
const SPEED = 100 

##
# Export variables
##

@export_category("Sound Effects")
@export var enter_sound: AudioStreamPlayer2D
@export var exit_sound: AudioStreamPlayer2D

var destination: Destination

##
# Variables
##

## If true, the spaceship cannot move. 
var locked := true

##
# Functions
##

func _ready() -> void:
	connect("travel", _travel_to_planet)
	
	enter_sound.play()
	await get_tree().create_timer(0.8).timeout
	locked = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a") and destination is Destination:
		emit_signal("travel")


func _travel_to_planet():
	locked = true
	exit_sound.play()
	await get_tree().create_timer(1).timeout
	Game.emit_signal("change_scene", destination.scene)


func _physics_process(_delta: float) -> void:
	_handle_input()
	move_and_slide()


func _handle_input() -> void:
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	var direction = Vector2(horizontal_direction, vertical_direction).normalized() if !locked else Vector2.ZERO
	velocity = direction * SPEED
