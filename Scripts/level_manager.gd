extends Node
@export var selected_tower_scene: PackedScene
@export var selected_tower_status: StatusTorre
@onready var ui_controller = $Control
@onready var enemy_controller = $enemy_controller
var vida_atual: int = 15
var dinheiro_atual: int = 10
var choose_tower := true
var inventario_magia : Array[StatusMagia]

func _ready() -> void:
	ui_controller.atualizar_vida(vida_atual)
	ui_controller.atualizar_dinheiro(dinheiro_atual)
	ui_controller.atualizar_onda(enemy_controller.wave)
	pass

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

# --- INVENTÁRIO DE MAGIAS ---
func adicionar_magia_ao_jogador(magia: StatusMagia) -> bool:
	if dinheiro_atual < magia.valor:
		print("Dinheiro insuficiente para comprar: ", magia.nome)
		return false
	
	gastar_dinheiro(magia.valor)
	inventario_magia.append(magia)
	print("Magia adicionada ao inventário: ", magia.nome)
	return true
