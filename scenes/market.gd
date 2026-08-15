extends Button
@onready var market_buy = $"../../market_buy"

func _ready() -> void:
	pressed.connect(_button_pressed)

func _button_pressed() -> void:
	market_buy.abrir_loja_de_magias()
	
