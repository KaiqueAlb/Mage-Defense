extends Node

@export var selected_tower_scene: PackedScene
@export var selected_tower_status: StatusTorre
@onready var ui_controller = $Control

var vida_atual: int = 15
var dinheiro_atual: int = 10

var choose_tower := true

func _ready() -> void:
	ui_controller.atualizar_vida(vida_atual)
	ui_controller.atualizar_dinheiro(dinheiro_atual)
	pass

func _process(delta: float) -> void:
	
	pass
	
func tomar_dano(dano: int):
	vida_atual -= dano
	ui_controller.atualizar_vida(vida_atual)

func ganhar_dinheiro(din):
	dinheiro_atual += din
	ui_controller.atualizar_dinheiro(dinheiro_atual)
