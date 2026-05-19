extends Button

@onready var level_manager = get_parent()

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	if level_manager.selected_tower_scene:
		var tower = level_manager.selected_tower_scene.instantiate()
		tower.status = level_manager.selected_tower_status
		add_child(tower)
		tower.position = Vector2.ZERO
		tower.position.x +=25
		tower.position.y +=25
		disabled = true
