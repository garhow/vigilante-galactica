extends Sprite2D

@onready var parent: Enemy = get_parent()

func _ready() -> void:
	parent.connect("damaged", _on_damaged)

func _on_damaged(_damage: int) -> void:
	for i in range(2):
		visible = not visible
		await get_tree().create_timer(0.05).timeout
