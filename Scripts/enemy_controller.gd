extends Node

var DIFICULDADE_MINIMA;
var DIFICULDADE_MAXIMA;

var enemy = preload("res://scenes/inimigo.tscn")

@export var wave: int = 1
@export var enemy_count: int = 3
@export var tipos_de_inimigo: Array[StatusInimigo] = []
@export var tipos_de_boss: Array[StatusInimigo] = []

var enemy_alive: int = 0
var timer_to_spawn: float = 0.0
var boss: bool = false

var fator_dificuldade: float = 1.0
var multiplicador_vida_boss: float = 1.0
var mortos_na_onda: int = 0
var vazaram_na_onda: int = 0
var dano_na_onda: int = 0
var onda_finalizada: bool = false

@onready var lista_caminhos = [$"../Path2D", $"../Path2D2", $"../Path2D3"]
@onready var enemy_path: Path2D = lista_caminhos.pick_random()
@onready var torre_1: Button = $"../Torre_slot"
@onready var torre_2: Button = $"../Torre_slot_2"
@onready var torre_3: Button = $"../Torre_slot_3"
@onready var mago: TextureRect = $"../Mago"
@onready var level_manager = $".."
@onready var market_e_next_wave = $"../market_e_next_wave"

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

	for caminho in lista_caminhos:
		if caminho != enemy_path:
			caminho.visible = false

func _process(delta: float) -> void:
	timer_to_spawn -= delta

	if timer_to_spawn <= 0.0 and enemy_count > 0:
		spawn_enemy()
		timer_to_spawn = 3.0
		enemy_count -= 1
		enemy_alive += 1

	if enemy_alive == 0 and enemy_count == 0 and !onda_finalizada:
		finalizar_onda()

func spawn_enemy() -> void:
	var instance = enemy.instantiate()
	if boss:
		instance.status = tipos_de_boss.pick_random()
	else:
		instance.status = tipos_de_inimigo.pick_random()
	instance.position = Vector2(100, 100)
	enemy_path.add_child(instance)

func registrar_abate() -> void:
	enemy_alive -= 1
	mortos_na_onda += 1

func progressao_vida_comum(onda_atual: int) -> int:
	if onda_atual >= 1 and onda_atual <= 4:
		return onda_atual - 1
	if onda_atual >= 6 and onda_atual <= 9:
		return onda_atual - 2
	if onda_atual >= 11 and onda_atual <= 14:
		return onda_atual - 3
	if onda_atual >= 16 and onda_atual <= 19:
		return onda_atual - 4
	return 0

func calcular_vida_boss(vida_base: int, onda_atual: int) -> int:
	# Bosses ganham vida base, crescimento por onda e os fatores de dificuldade.
	var fator_onda: float = 1.0 + max(0, onda_atual - 5) * 0.08
	return max(1, roundi(vida_base * multiplicador_vida_boss * fator_dificuldade * fator_onda))

func registrar_vazamento(dano: int) -> void:
	enemy_alive -= 1
	vazaram_na_onda += 1
	dano_na_onda += dano
	level_manager.tomar_dano(dano)

func finalizar_onda() -> void:
	onda_finalizada = true
	ajustar_dificuldade()
	market_e_next_wave.visible = true

func ajustar_dificuldade() -> void:
	if vazaram_na_onda > 0:
		var reducao : float = 0.05 + min(0.15, dano_na_onda * 0.02)
		fator_dificuldade = max(
			DIFICULDADE_MINIMA,
			fator_dificuldade - reducao
		)
	else:
		fator_dificuldade = min(
			DIFICULDADE_MAXIMA,
			fator_dificuldade + 0.05
		)

func next_wave() -> void:
	wave += 1
	boss = false
	onda_finalizada = false
	mortos_na_onda = 0
	vazaram_na_onda = 0
	dano_na_onda = 0
	timer_to_spawn = 0.0

	match wave:
		2, 7, 12, 17:
			enemy_count = 5

		3, 8, 13, 18:
			enemy_count = 7

		4, 9, 14, 19:
			enemy_count = 9

		5, 10, 15, 20:
			enemy_count = 1
			boss = true

		6, 11, 16:
			enemy_count = 3

		_:
			enemy_count = int((wave / 4) * fator_dificuldade)
			boss = true

	if !boss:
		enemy_count = max(1, roundi(enemy_count * fator_dificuldade))

	level_manager.aumentar_onda(wave)
	market_e_next_wave.visible = false
