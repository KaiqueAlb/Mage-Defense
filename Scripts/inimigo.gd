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
	var vida_base: int = status.vida + enemy_controller.wave
	if enemy_controller.boss:
		vida = enemy_controller.calcular_vida_boss(vida_base, enemy_controller.wave)
	else:
		vida_base += enemy_controller.progressao_vida_comum(enemy_controller.wave)
		if status.tipo == StatusInimigo.Tipo.ALIEN:
			vida = max(1, roundi(vida_base * enemy_controller.fator_dificuldade) / 2)
		else:
			vida = max(1, roundi(vida_base * enemy_controller.fator_dificuldade))
	sprite.texture = status.sprite
	hitbox.add_to_group("inimigos")

func _process(delta: float) -> void:
	_mover(delta)
	rotation = rad_to_deg(90)
	scale.x = 0.75
	scale.y = 0.75
	_fim_do_caminho()
	

func _mover(delta: float) -> void:
	progress += delta * status.vel

func receber_dano(valor: int):
	vida -= valor
	if vida <= 0:
		level_manager.ganhar_dinheiro(5)
		enemy_controller.registrar_abate()
		queue_free()

func _fim_do_caminho():
	if progress_ratio >= 1.0:
		enemy_controller.registrar_vazamento(status.dano)
		queue_free()
