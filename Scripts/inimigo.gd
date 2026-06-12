extends PathFollow2D

@export_category("Parametros do Inimigo")
@export var status: StatusInimigo

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Area2D

var vida := 10

func _ready() -> void:
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
		queue_free()

func _fim_do_caminho():
	if progress_ratio >= 1.0:
		queue_free()
