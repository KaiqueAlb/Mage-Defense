extends Node

@export var selected_tower_scene: PackedScene
@export var selected_tower_status: StatusTorre
@export var ui_controller: Node

var vida_atual: int = 15
var dinheiro_atual: int = 10

func _ready() -> void:
	ui_controller.atualizar_vida(vida_atual)
	ui_controller.atualizar_dinheiro(dinheiro_atual)

func _process(delta: float) -> void:
	pass

func tomar_dano(dano: int):
	vida_atual -= dano
	ui_controller.atualizar_vida(vida_atual)

func  ganhar_dinheiro(din):
	dinheiro_atual += din
	ui_controller.atualizar_dinheiro(dinheiro_atual)
