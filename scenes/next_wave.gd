extends Button
@onready var enemy_controller = $"../../enemy_controller"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	enemy_controller.next_wave()
	
func _on_mouse_entered() -> void:
	self.scale.x = 0.19
	self.scale.y = 0.19

func _on_mouse_exited() -> void:
	self.scale.x = 0.15
	self.scale.y = 0.15
