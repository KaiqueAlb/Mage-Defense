extends Button
@export var status: StatusTorre
var projetil_scene = preload("res://scenes/projetil.tscn")
@onready var sprite: Sprite2D = $Sprite2D
@onready var detection_area: Area2D = $Area2D
@onready var click_area: Area2D = $Sprite2D/area_sprite
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
	var direcao = (alvo.global_position - global_position).normalized()
	sprite.rotation = direcao.angle()
	var projetil = projetil_scene.instantiate()
	projetil.get_node("Sprite2D").texture = status.projectile
	get_tree().current_scene.add_child(projetil)
	projetil.global_position = global_position
	projetil.position.x += 55
	projetil.position.y += 55
	projetil.alvo = alvo
	projetil.dano = dano

func _on_area_entered(area):
	if area.is_in_group("inimigos"):
		inimigos.append(area)

func _on_area_exited(area):
	if area.is_in_group("inimigos"):
		inimigos.erase(area)

func adicionar_magia(magia: StatusMagia) -> void:
	status.magias.append(magia)
	match magia.tipo:
		StatusMagia.Tipo.DANO:
			dano += magia.valor
		StatusMagia.Tipo.ALCANCE:
			alcance += magia.valor
			detection_area.scale.x = alcance
			detection_area.scale.y = alcance
		StatusMagia.Tipo.VELOCIDADE:
			vel += magia.valor

func aplicar_magias() -> void:
	for magia in status.magias:
		match magia.tipo:
			StatusMagia.Tipo.DANO:
				dano += magia.valor
			StatusMagia.Tipo.ALCANCE:
				alcance += magia.valor
			StatusMagia.Tipo.VELOCIDADE:
				vel += magia.valor

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().get_first_node_in_group("game_controller").aplicar_magia_na_torre(self)


func _on_area_sprite_mouse_entered() -> void:
	pass # Replace with function body.
