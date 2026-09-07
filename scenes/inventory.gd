extends Control
@export var magia_botao_scene: PackedScene
@onready var game_controller = $".."
@onready var lista_magias = $lista_magias

func _ready() -> void:
	game_controller.inventario_mudou.connect(atualizar_lista_magias)
	atualizar_lista_magias()

func _on_rich_text_label_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if self.position.x == 0:
			self.position.x -= 200
		else:
			self.position.x = 0

func atualizar_lista_magias() -> void:
	for filho in lista_magias.get_children():
		filho.queue_free()
	
	for i in range(game_controller.inventario_magia.size()):
		var magia = game_controller.inventario_magia[i]
		var item_magia = magia_botao_scene.instantiate()
		item_magia.status = magia
		item_magia.position.x = -32 + (i * 70)
		item_magia.position.y = -46
		item_magia.scale.x = 0.25
		item_magia.scale.y = 0.25
		lista_magias.add_child(item_magia)
