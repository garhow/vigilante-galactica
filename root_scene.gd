extends Node

# Konami code
const KONAMI_CODE: Array[String] = ["up", "up", "down", "down", "left", "right", "left", "right", "b", "a", "start"]
var konami_index: int:
	set = _konami_check

var current_scene: CanvasItem

var locked: bool = false

func _ready() -> void:
	Game.connect("change_scene", _change_scene)
	Game.emit_signal("change_scene", preload("res://Scenes/User Interface/Startup.tscn"))


func _input(event: InputEvent) -> void:
	if event.is_pressed() and konami_index < KONAMI_CODE.size():
		if event.is_action_pressed(KONAMI_CODE[konami_index]): konami_index += 1
		else: konami_index = 0


func _change_scene(scene: PackedScene):
	if locked: return
	
	locked = true
	
	if current_scene != null: _modify_alpha(true)
	
	await get_tree().create_timer(0.5).timeout
	if current_scene != null: current_scene.queue_free()
	
	current_scene = scene.instantiate()
	current_scene.modulate.a = 0
	
	add_child(current_scene)
	
	for node in get_tree().get_nodes_in_group("Modulate"): node.color.a = 0
	
	_modify_alpha(false)
	
	locked = false


func _modify_alpha(subtract: bool) -> void:
	for i in range(4):
		await get_tree().create_timer(0.05).timeout
		current_scene.modulate.a += -0.25 if subtract else 0.25
		for node in get_tree().get_nodes_in_group("Modulate"):
			node.color.a += -0.25 if subtract else 0.25


func _konami_check(value: int) -> void:
	konami_index = value
	if value >= KONAMI_CODE.size():
		Game.emit_signal("change_scene", load("res://Scenes/User Interface/Troll.tscn"))
