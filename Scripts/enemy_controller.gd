extends Node

var enemy = preload("res://inimigo.tscn")

@export var wave: int = 1
@export var enemy_count = 0
var enemy_alive = 0
@onready var lista_caminhos = [$"../Path2D", $"../Path2D2", $"../Path2D3"]
@onready var enemy_path: Path2D = lista_caminhos.pick_random()
@onready var torre_1: Button = $"../Torre_slot"
@onready var torre_2: Button = $"../Torre_slot_2"
@onready var torre_3: Button = $"../Torre_slot_3"
@onready var mago: TextureRect = $"../TextureRect"
@onready var level_manager = $".."
@onready var market_e_next_wave = $"../market_e_next_wave"

var timer_to_spawn: int = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match enemy_path.name:
		"Path2D":
			torre_1.position = Vector2(211, 291)
			torre_2.position = Vector2(571, 457)
			torre_3.position = Vector2(676, 205)
			mago.position = Vector2(1008, 5)
			pass
		"Path2D2":
			torre_1.position = Vector2(84, 178)
			torre_2.position = Vector2(371, 312)
			torre_3.position = Vector2(641, 175)
			mago.position = Vector2(1008, 183)
			pass
		"Path2D3":
			torre_1.position = Vector2(317, 324)
			torre_2.position = Vector2(642, 127)
			torre_3.position = Vector2(955, 18)
			mago.position = Vector2(1008, 397)
			pass
		pass
	for i in lista_caminhos:
		if enemy_path != i:
			i.visible = false
			pass
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_to_spawn-=1
	if timer_to_spawn < 0.0 && enemy_count > 0:
		spawn_enemy()
		timer_to_spawn = 300.0;
		enemy_count-=1;
		enemy_alive+=1
		pass
	if enemy_alive == 0 && enemy_count == 0:
		market_e_next_wave.visible = true
	pass
	
func spawn_enemy() -> void:
	var instance = enemy.instantiate()
	instance.position = Vector2(100, 100)
	enemy_path.add_child(instance)
	pass
	
func next_wave() -> void:
	wave +=1
	enemy_count = 5
	level_manager.aumentar_onda(wave)
	market_e_next_wave.visible = false
	pass
