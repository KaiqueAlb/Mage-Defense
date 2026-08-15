extends Control

@onready var life_label: Label= $"Header/Vida Text"
@onready var din_label: Label= $"Header/Din Text"
@onready var onda_label: Label= $"Header/Onda Text"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func atualizar_vida(vida:int):
	life_label.text = "= " + String.num_int64(vida)
	
func atualizar_dinheiro(din:int):
	din_label.text = "= " + String.num_int64(din)

func atualizar_onda(wave:int):
	onda_label.text = "onda: " + String.num_int64(wave)
