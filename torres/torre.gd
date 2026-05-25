extends Button

@export var status: StatusTorre

@onready var dano: int
@onready var vel: float
@onready var sprite: Sprite2D = $Sprite2D
@onready var detection_area: Area2D = $Area2D
var enemy = preload("res://inimigo.tscn")

func _ready() -> void:
	if status:
		dano = status.dano
		vel = status.vel
		sprite.texture = status.sprite
		detection_area.scale.x = status.range
		detection_area.scale.y = status.range
		
func _process(delta: float) -> void:
	pass
	
func attack() -> void:
	pass
