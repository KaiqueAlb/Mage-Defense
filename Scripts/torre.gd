extends Button

@export var status: StatusTorre
var projetil_scene = preload("res://scenes/projetil.tscn")

@onready var sprite: Sprite2D = $Sprite2D
@onready var detection_area: Area2D = $Area2D

var dano: int
var vel: float
var alcance: float

var inimigos: Array[Area2D] = []
var cooldown := 0.0



func _ready() -> void:
	if status:
		dano = status.dano
		vel = status.vel
		alcance = status.alcance
		print(alcance)
		sprite.texture = status.sprite

		detection_area.scale.x = status.alcance
		detection_area.scale.y = status.alcance

	detection_area.area_entered.connect(_on_area_entered)
	detection_area.area_exited.connect(_on_area_exited)
	
	aplicar_magias()

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
	projetil.get_node("Sprite2D").texture = status.projectile
	get_tree().current_scene.add_child(projetil)

	projetil.global_position = global_position

	projetil.alvo = alvo
	projetil.dano = dano

func _on_area_entered(area):
	if area.is_in_group("inimigos"):
		inimigos.append(area)

func _on_area_exited(area):
	if area.is_in_group("inimigos"):
		inimigos.erase(area)

func aplicar_magias():
	for magia in status.magias:
		match magia.tipo:
			StatusMagia.Tipo.DANO:
				dano += magia.valor
			StatusMagia.Tipo.ALCANCE:
				alcance += magia.valor
			StatusMagia.Tipo.VELOCIDADE:
				vel += magia.valor
