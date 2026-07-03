extends Button

@export var status: StatusTorre
var projetil_scene = preload("res://scenes/projetil.tscn")

@onready var sprite: Sprite2D = $Sprite2D
@onready var detection_area: Area2D = $Area2D

var dano: int
var vel: float

var inimigos: Array[Area2D] = []
var cooldown := 0.0

func _ready() -> void:
	if status:
		dano = status.dano
		vel = status.vel
		sprite.texture = status.sprite

		detection_area.scale.x = status.range
		detection_area.scale.y = status.range

	detection_area.area_entered.connect(_on_area_entered)
	detection_area.area_exited.connect(_on_area_exited)

func _process(delta: float) -> void:
	cooldown -= delta

	inimigos = inimigos.filter(
		func(area): return is_instance_valid(area)
	)

	if inimigos.is_empty():
		return

	if cooldown <= 0:
		attack(inimigos[0])
		cooldown = vel

func attack(alvo: Area2D) -> void:
	if !is_instance_valid(alvo):
		return

	var projetil = projetil_scene.instantiate()

	get_tree().current_scene.add_child(projetil)

	projetil.global_position = global_position

	projetil.alvo = alvo
	projetil.dano = dano

func _on_area_entered(area):
	if area.is_in_group("inimigos"):
		print("Entrou:", area)
		inimigos.append(area)

func _on_area_exited(area):
	if area.is_in_group("inimigos"):
		print("Saiu:", area)
		inimigos.erase(area)
