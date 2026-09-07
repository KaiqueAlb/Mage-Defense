extends Node
@export var selected_magia_scene: PackedScene
var magia_selecionada: StatusMagia
@export var selected_tower_scene: PackedScene
@export var selected_tower_status: StatusTorre
@onready var ui_controller = $Control
@onready var enemy_controller = $enemy_controller
var torres_no_nivel: int = 0
var vida_atual: int = 15
var vida_maxima: int = 15
var dinheiro_atual: int = 10
var choose_tower := true
var inventario_magia: Array[StatusMagia]
signal inventario_mudou

func _ready() -> void:
	add_to_group("game_controller")
	ui_controller.atualizar_vida(vida_atual)
	ui_controller.atualizar_dinheiro(dinheiro_atual)
	ui_controller.atualizar_onda(enemy_controller.wave)

func _process(delta: float) -> void:
	pass

func tomar_dano(dano: int):
	vida_atual -= dano
	ui_controller.atualizar_vida(vida_atual)

func ganhar_dinheiro(din):
	dinheiro_atual += din
	ui_controller.atualizar_dinheiro(dinheiro_atual)

func gastar_dinheiro(valor: int) -> void:
	dinheiro_atual -= valor
	ui_controller.atualizar_dinheiro(dinheiro_atual)

func aumentar_onda(onda):
	ui_controller.atualizar_onda(enemy_controller.wave)

func selecionar_magia(magia: StatusMagia) -> void:
	if magia.tipo == StatusMagia.Tipo.CURA:
		vida_atual = min(vida_atual + int(magia.valor), vida_maxima)
		ui_controller.atualizar_vida(vida_atual)

		inventario_magia.erase(magia)
		inventario_mudou.emit()
		return
	magia_selecionada = magia
	print("Magia selecionada: ", magia.nome)

func aplicar_magia_na_torre(torre) -> void:
	if magia_selecionada:
		torre.adicionar_magia(magia_selecionada)
		print("Magia ", magia_selecionada.nome, " aplicada na torre!")
		inventario_magia.erase(magia_selecionada)
		magia_selecionada = null
		inventario_mudou.emit()

func adicionar_magia_ao_jogador(magia: StatusMagia) -> bool:
	if dinheiro_atual < magia.preco:
		print("Dinheiro insuficiente para comprar: ", magia.nome)
		return false
	
	gastar_dinheiro(magia.preco)
	inventario_magia.append(magia)
	inventario_mudou.emit()
	print("Magia adicionada ao inventário: ", magia.nome)
	return true
