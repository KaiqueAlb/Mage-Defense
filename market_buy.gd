extends Node2D
@export var magia_status: Array[StatusMagia]
@export var torre_status: Array[StatusTorre]
@export var torre_scene_generica: PackedScene
@onready var controller = $".."
@onready var info = $RichTextLabel
@onready var market_buy = $"."
@onready var botao_confirmar = $Button_confirmar
@onready var botao_rerrolar = $Button_rerrolar
@onready var magias := [
	$Magia1,
	$Magia2,
	$Magia3
]
var itens_sorteados: Array = []
var item_escolhido: Dictionary = {}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for magia in magias:
		magia.process_mode = Node.PROCESS_MODE_ALWAYS
	botao_confirmar.process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false 

func abrir_loja_de_magias() -> void:
	if magia_status.size() + torre_status.size() < 3:
		return
	
	sortear_itens(false)
	visible = true
	get_tree().paused = true

func sortear_itens(resortear: bool) -> void:
	if not itens_sorteados.is_empty() and not resortear:
		return
	var pool: Array = []
	for m in magia_status:
		pool.append({"tipo": "magia", "resource": m})
	if controller.torres_no_nivel != 3:
		for t in torre_status:
			pool.append({"tipo": "torre", "resource": t})
	
	pool.shuffle()
	itens_sorteados = pool.slice(0, 3)
	
	item_escolhido = {}
	info.text = "Escolha uma magia ou torre, passe o mouse em cima para checar suas informações"
	botao_confirmar.disabled = true
	botao_confirmar.text = "Selecione um item"
	
	for i in range(3):
		magias[i].get_node("Sprite2D").texture = itens_sorteados[i]["resource"].sprite

func pode_comprar(preco: int) -> bool:
	return controller.dinheiro_atual >= preco

func aplicar_magia_confirmada() -> void:
	if item_escolhido.is_empty():
		return
	
	var resource = item_escolhido["resource"]
	var tipo = item_escolhido["tipo"]
	var sucesso = false
	
	if tipo == "magia":
		sucesso = controller.adicionar_magia_ao_jogador(resource)
	else:
		sucesso = comprar_torre(resource)
	
	if sucesso:
		print("Item comprado: ", resource.nome)
		get_tree().paused = false
		visible = false
		itens_sorteados = [];
	else:
		info.text = "Dinheiro insuficiente"

func comprar_torre(torre: StatusTorre) -> bool:
	if controller.dinheiro_atual < torre.preco:
		return false
	controller.gastar_dinheiro(torre.preco)
	controller.selected_tower_scene = torre_scene_generica
	controller.selected_tower_status = torre
	return true

func _on_magia_1_input_event(viewport, event, shape_idx):
	_selecionar_item(0)
func _on_magia_2_input_event(viewport, event, shape_idx):
	_selecionar_item(1)
func _on_magia_3_input_event(viewport, event, shape_idx):
	_selecionar_item(2)

func _selecionar_item(indice_slot: int) -> void:
	item_escolhido = itens_sorteados[indice_slot]
	var resource = item_escolhido["resource"]
	var preco = resource.preco if item_escolhido["tipo"] == "magia" else resource.preco
	botao_confirmar.disabled = false
	if pode_comprar(preco):
		botao_confirmar.text = "Comprar: " + resource.nome
	else:
		botao_confirmar.text = "Sem dinheiro: " + resource.nome

func _on_magia_1_mouse_entered():
	_mostrar_info(0)
func _on_magia_1_mouse_exited():
	atualizar_texto_padrao()
func _on_magia_2_mouse_entered():
	_mostrar_info(1)
func _on_magia_2_mouse_exited():
	atualizar_texto_padrao()
func _on_magia_3_mouse_entered():
	_mostrar_info(2)
func _on_magia_3_mouse_exited():
	atualizar_texto_padrao()

func _mostrar_info(indice_slot: int) -> void:
	var resource = itens_sorteados[indice_slot]["resource"]
	var prefixo = "Magia: " if itens_sorteados[indice_slot]["tipo"] == "magia" else "Torre: "
	info.text = prefixo + resource.nome + " Preco: " + String.num_int64(resource.preco) + " $"

func atualizar_texto_padrao():
	if not item_escolhido.is_empty():
		var resource = item_escolhido["resource"]
		info.text = "Selecionado: " + resource.nome + ".\nClique em Confirmar para comprar"
	else:
		info.text = "Escolha uma magia ou torre, passe o mouse em cima para checar suas informações"

func _on_button_confirmar_pressed() -> void:
	aplicar_magia_confirmada()

func _on_close_market_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().paused = false
		market_buy.visible = false

func _on_button_rerrolar_pressed() -> void:
	if controller.dinheiro_atual < 2:
		info.text = "Dinheiro insuficiente"
		return
	controller.gastar_dinheiro(2)
	sortear_itens(true)

func _on_button_rerrolar_mouse_entered() -> void:
	botao_rerrolar.scale.x = 0.19
	botao_rerrolar.scale.y = 0.19

func _on_button_rerrolar_mouse_exited() -> void:
	botao_rerrolar.scale.x = 0.15
	botao_rerrolar.scale.y = 0.15

func _on_button_confirmar_mouse_entered() -> void:
	botao_confirmar.scale.x = 0.19
	botao_confirmar.scale.y = 0.19

func _on_button_confirmar_mouse_exited() -> void:
	botao_confirmar.scale.x = 0.15
	botao_confirmar.scale.y = 0.15
