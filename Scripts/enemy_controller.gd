extends Node

var enemy = preload("res://inimigo.tscn")

@export var wave: int = 1
@export var enemy_count = 3
var enemy_alive = 0
@onready var lista_caminhos = [$"../Path2D", $"../Path2D2", $"../Path2D3"]
@onready var enemy_path: Path2D = lista_caminhos.pick_random()
var timer_to_spawn: int = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(lista_caminhos)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_to_spawn-=1
	if wave == 1.0 && timer_to_spawn < 0.0 && enemy_count > 0:
		spawn_enemy()
		timer_to_spawn = 300.0;
		enemy_count-=1;
		enemy_alive+=1
		pass
	pass
	
func spawn_enemy() -> void:
	var instance = enemy.instantiate()
	instance.position = Vector2(100, 100)
	enemy_path.add_child(instance)
	pass
