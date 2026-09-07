extends PathFollow2D

@export_category("Parametros do Inimigo")
@export var status: StatusInimigo

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Area2D
@onready var enemy_controller: Node = $"../../enemy_controller"
@onready var level_manager = get_tree().get_first_node_in_group("game_controller")

var vida

func _ready() -> void:
	vida = status.vida + enemy_controller.wave
	sprite.texture = status.sprite
	hitbox.add_to_group("inimigos")

func _process(delta: float) -> void:
	_mover(delta)
	rotation = 180
	_fim_do_caminho()
	

func _mover(delta: float) -> void:
	progress += delta * status.vel

func receber_dano(valor: int):
	vida -= valor
	if vida <= 0:
		level_manager.ganhar_dinheiro(5)
		enemy_controller.enemy_alive-=1
		print(enemy_controller.enemy_alive)
		queue_free()

func _fim_do_caminho():
	if progress_ratio >= 1.0:
		level_manager.tomar_dano(status.dano)
		enemy_controller.enemy_alive-=1
		print(enemy_controller.enemy_alive)
		queue_free()
