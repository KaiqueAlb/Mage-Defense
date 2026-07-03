extends Button

@onready var level_manager = get_parent()

func _ready() -> void:
	pressed.connect(_button_pressed)

func _process(delta: float) -> void:
	if level_manager.dinheiro_atual >= 10:
		disabled = false
	else :
		disabled = true

func _button_pressed() -> void:
	if level_manager.selected_tower_scene:
		var tower = level_manager.selected_tower_scene.instantiate()
		tower.status = level_manager.selected_tower_status
		get_node("/root").add_child(tower)
		hide()
		tower.position = Vector2.ZERO
		tower.position.x = position.x + 100
		tower.position.y = position.y + 100
		level_manager.ganhar_dinheiro(-10)
		print(tower.position)
		disabled = true
