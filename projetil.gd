extends Node2D

@onready var area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D

var alvo: Area2D
var dano: int
var velocidade := 500.0

func _process(delta: float) -> void:
	if alvo == null or !is_instance_valid(alvo):
		queue_free()
		return

	var direcao = (alvo.global_position - global_position).normalized()

	global_position += direcao * velocidade * delta
	rotation = direcao.angle()

	for hit_area in area.get_overlapping_areas():
		if hit_area.is_in_group("inimigos"):
			var inimigo = hit_area.get_parent()

			if inimigo.has_method("receber_dano"):
				inimigo.receber_dano(dano)

			queue_free()
			return
