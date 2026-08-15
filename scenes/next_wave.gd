extends Button
@onready var enemy_controller = $"../../enemy_controller"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	enemy_controller.next_wave()
	
