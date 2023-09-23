extends Control

var started := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("start"):
		if started: return
		started = true
		$Sound.play()
		await $Sound.finished
		Game.emit_signal("change_scene", preload("res://Scenes/World Map.tscn"))
