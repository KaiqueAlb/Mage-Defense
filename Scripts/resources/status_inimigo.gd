extends Resource
class_name StatusInimigo

enum Tipo {
	ALIEN,
	MONSTRO,
	SOLDADO
}

@export var vida: int
@export var vel: float
@export var sprite: CompressedTexture2D
@export var dano: int
@export var tipo: Tipo
