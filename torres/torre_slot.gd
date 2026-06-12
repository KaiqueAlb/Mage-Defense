extends Button

@onready var level_manager = get_parent()

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	if level_manager.selected_tower_scene:
		var tower = level_manager.selected_tower_scene.instantiate()
		tower.status = level_manager.selected_tower_status
		get_node("/root").add_child(tower)
		tower.global_position = global_position
		hide()
		tower.position = Vector2.ZERO
		tower.position.x = position.x
		tower.position.y = position.y
		disabled = true
