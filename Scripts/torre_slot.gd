extends Button
@onready var level_manager = get_parent()

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	if level_manager.selected_tower_scene:
		var tower = level_manager.selected_tower_scene.instantiate()
		tower.status = level_manager.selected_tower_status.duplicate()
		get_node("/root").add_child(tower)
		hide()
		tower.position.x = position.x + 46
		tower.position.y = position.y + 46
		level_manager.selected_tower_scene = null
		level_manager.selected_tower_status = null
		level_manager.torres_no_nivel = level_manager.torres_no_nivel + 1
		disabled = true
