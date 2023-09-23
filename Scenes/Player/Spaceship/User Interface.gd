extends Control

@export_category("Status Indicators")
@export var life_count: Label
@export var mission_indicator: Label

func _ready() -> void:
	# Connect signals
	Game.connect("mission_changed", update_mission)
	
	# Initialize indicators
	update_lives()
	update_mission(Game.current_mission)


func update_lives() -> void:
	life_count.text = "*%s" % Game.lives


func update_mission(mission: Game.Mission):
	mission_indicator.text = mission.description
