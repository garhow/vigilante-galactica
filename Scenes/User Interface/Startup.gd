extends Control

func _load_title_screen(_anim_name: String) -> void:
	Game.emit_signal("change_scene", load("res://Scenes/User Interface/Title Screen.tscn"))
