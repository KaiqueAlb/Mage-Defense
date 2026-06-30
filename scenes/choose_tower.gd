extends Node2D

@export var tower_scenes: Array[PackedScene]
@export var tower_status: Array[StatusTorre]

@onready var level_manager = get_parent()

@onready var torres := [
	$Torre1,
	$Torre2,
	$Torre3
]

var torres_sorteadas: Array[int]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true

	for i in range(tower_status.size()):
		torres_sorteadas.append(i)

	torres_sorteadas.shuffle()

	for i in range(3):
		torres[i].get_node("Sprite2D").texture = tower_status[torres_sorteadas[i]].sprite

func escolher_torre(opcao: int):
	var indice = torres_sorteadas[opcao]

	level_manager.selected_tower_scene = tower_scenes[indice]
	level_manager.selected_tower_status = tower_status[indice]

	get_tree().paused = false
	queue_free()


func _on_torre_1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		escolher_torre(0)

func _on_torre_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		escolher_torre(1)

func _on_torre_3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		escolher_torre(2)
		
