extends Control

@export_category("Status Indicators")
@export var life_count: Label
@export var health_bar: ProgressBar
@export var health_indicator: Label
@export var time_indicator: Label

func _ready() -> void:
	# Connect signals
	Game.connect("health_changed", update_health)
	
	# Initialize indicators
	update_lives()


func _physics_process(_delta: float) -> void:
	time_indicator.text = _format_seconds(Game.time)
	


func update_lives() -> void:
	life_count.text = "*%s" % Game.lives


func update_health(value: int) -> void:
	health_bar.value = value
	#health_indicator.text = "%s HP" % str(value)


func _format_seconds(time: float) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	return "%02d:%02d" % [minutes, seconds]
