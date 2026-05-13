extends Button

@export var status: StatusTorre

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if status:
		sprite.texture = status.sprite
		
func _process(delta: float) -> void:
	pass
