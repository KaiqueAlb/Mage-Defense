extends Node2D
@export var magia_status: Array[StatusMagia]
var magia_escolhida: StatusMagia
@onready var info = $RichTextLabel
@onready var market_buy = $"."
@onready var botao_confirmar = $Button_confirmar
@onready var magias := [
	$Magia1,
	$Magia2,
	$Magia3
]
var magias_sorteadas: Array[int]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for magia in magias:
		magia.process_mode = Node.PROCESS_MODE_ALWAYS
	
	botao_confirmar.process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Começa escondido
	visible = false 

func abrir_loja_de_magias() -> void:
	if magia_status.size() < 3:
		print("Erro: Você precisa de pelo menos 3 magias no magia_status!")
		return
		
	magias_sorteadas.clear()
	magia_escolhida = null
	info.text = "Escolha uma magia, passe o mouse em cima para checar suas informações"
	
	botao_confirmar.disabled = true
	botao_confirmar.text = "Selecione uma magia"
	
	for i in range(magia_status.size()):
		magias_sorteadas.append(i)
	
	magias_sorteadas.shuffle()
	
	for i in range(3):
		var indice = magias_sorteadas[i]
		magias[i].get_node("Sprite2D").texture = magia_status[indice].sprite
	
	visible = true
	get_tree().paused = true

# --- VERIFICAÇÃO DE DINHEIRO (Opção B) ---
func pode_comprar(preco: int) -> bool:
	return get_parent().dinheiro_atual >= preco

func aplicar_magia_confirmada() -> void:
	if magia_escolhida:
		var sucesso = get_parent().adicionar_magia_ao_jogador(magia_escolhida)
		if sucesso:
			print("Magia confirmada e aplicada: ", magia_escolhida.nome)
			get_tree().paused = false
			visible = false
		else:
			info.text = "Dinheiro insuficiente!"

# --- CLIQUES NAS MAGIAS ---
func _on_magia_1_input_event(viewport, event, shape_idx):
	_selecionar_magia(0)
func _on_magia_2_input_event(viewport, event, shape_idx):
	_selecionar_magia(1)
func _on_magia_3_input_event(viewport, event, shape_idx):
	_selecionar_magia(2)

func _selecionar_magia(indice_slot: int) -> void:
	magia_escolhida = magia_status[magias_sorteadas[indice_slot]]
	botao_confirmar.disabled = false
	if pode_comprar(magia_escolhida.valor):
		botao_confirmar.text = "Comprar: " + magia_escolhida.nome
	else:
		botao_confirmar.text = "Sem dinheiro: " + magia_escolhida.nome

# --- TEXTOS DINÂMICOS NO MOUSE ENTERED ---
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
	var magia = magia_status[magias_sorteadas[indice_slot]]
	info.text = "Magia: " + magia.nome

func atualizar_texto_padrao():
	if magia_escolhida:
		info.text = "Selecionado: " + magia_escolhida.nome + ".\nClique em Confirmar para comprar!"
	else:
		info.text = "Escolha uma magia, passe o mouse em cima para checar suas informações"

# --- BOTÃO ÚNICO DE CONFIRMAÇÃO ---
func _on_button_confirmar_pressed() -> void:
	print("Botão Confirmar pressionado!")
	aplicar_magia_confirmada()

# --- BOTÃO DE FECHAR A LOJA (X) ---
func _on_close_market_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().paused = false
		market_buy.visible = false
