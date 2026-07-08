extends Control

@onready var life_label: Label= $"Header/Vida Text"
@onready var din_label: Label= $"Header/Din Text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func atualizar_vida(vida:int):
	life_label.text = "= " + String.num_int64(vida)
	
func atualizar_dinheiro(vida:int):
	din_label.text = "= " + String.num_int64(vida)
