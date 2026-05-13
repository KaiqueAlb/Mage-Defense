extends PathFollow2D

@export_category("Parametros do Inimigo")
@export var status: StatusInimigo

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sprite.texture = status.sprite
	anim.play("new_animation")


func _process(delta: float) -> void:
	_mover(delta)
	_morrer()


func _mover(delta:float) -> void:
	progress += delta * status.vel

func _morrer():
	if progress_ratio >= 1.0:
		queue_free()
