extends Node
var enemy = preload("res://scenes/inimigo.tscn")
@export var wave: int = 1
@export var enemy_count = 3
@export var tipos_de_inimigo: Array[StatusInimigo] = []
var enemy_alive = 0
@onready var lista_caminhos = [$"../Path2D", $"../Path2D2", $"../Path2D3"]
@onready var enemy_path: Path2D = lista_caminhos.pick_random()
@onready var torre_1: Button = $"../Torre_slot"
@onready var torre_2: Button = $"../Torre_slot_2"
@onready var torre_3: Button = $"../Torre_slot_3"
@onready var mago: TextureRect = $"../Mago"
@onready var level_manager = $".."
@onready var market_e_next_wave = $"../market_e_next_wave"
var timer_to_spawn: float = 0.0
var boss: bool = false

func _ready() -> void:
	match enemy_path.name:
		"Path2D":
			torre_1.position = Vector2(211, 291)
			torre_2.position = Vector2(571, 457)
			torre_3.position = Vector2(676, 205)
			mago.position = Vector2(1008, 5)
		"Path2D2":
			torre_1.position = Vector2(84, 178)
			torre_2.position = Vector2(371, 312)
			torre_3.position = Vector2(641, 175)
			mago.position = Vector2(1008, 183)
		"Path2D3":
			torre_1.position = Vector2(317, 324)
			torre_2.position = Vector2(642, 127)
			torre_3.position = Vector2(955, 100)
			mago.position = Vector2(1008, 397)
	for i in lista_caminhos:
		if enemy_path != i:
			i.visible = false

func _process(delta: float) -> void:
	timer_to_spawn -= delta
	if timer_to_spawn < 0.0 && enemy_count > 0:
		spawn_enemy()
		timer_to_spawn = 3.0
		enemy_count -= 1
		enemy_alive += 1
	if enemy_alive == 0 && enemy_count == 0:
		market_e_next_wave.visible = true

func spawn_enemy() -> void:
	var instance = enemy.instantiate()
	instance.status = tipos_de_inimigo.pick_random()
	instance.position = Vector2(100, 100)
	enemy_path.add_child(instance)

func next_wave() -> void:
	wave += 1
	match wave:
		2:
			enemy_count = 5
		3:
			enemy_count = 7
		4:
			enemy_count = 9
		5:	
			enemy_count = 1
			boss = true
	level_manager.aumentar_onda(wave)
	market_e_next_wave.visible = false
