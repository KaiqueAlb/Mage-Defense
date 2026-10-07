extends Button
@onready var enemy_controller = $"../../enemy_controller"
@onready var select_dificuldade = $".."
@onready var choose_tower = $"../../ChooseTower"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	enemy_controller.DIFICULDADE_MINIMA = 0.75
	enemy_controller.DIFICULDADE_MAXIMA = 1.50
	select_dificuldade.visible = false
	choose_tower.visible = true
	
func _on_mouse_entered() -> void:
	self.scale.x = 0.19
	self.scale.y = 0.19

func _on_mouse_exited() -> void:
	self.scale.x = 0.15
	self.scale.y = 0.15
