extends Button
@export var status: StatusMagia
@onready var game_controller = $"../../.."
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if status:
		sprite.texture = status.sprite
	add_to_group("magia_botoes")
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
		get_tree().call_group("magia_botoes", "_desmarcar")
		game_controller.selecionar_magia(status)
		modulate = Color(1, 1, 0.4)  # amarelado = selecionado

func _desmarcar() -> void:
	modulate = Color.WHITE
