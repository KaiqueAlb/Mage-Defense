extends Resource
class_name StatusMagia

enum Tipo {
	DANO,
	ALCANCE,
	VELOCIDADE,
	CURA
}

@export var nome: String
@export var descricao: String
@export var sprite: CompressedTexture2D
@export var tipo: Tipo
@export var preco: float
@export var valor: float
