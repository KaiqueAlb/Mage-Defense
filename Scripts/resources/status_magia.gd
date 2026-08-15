extends Resource
class_name StatusMagia

enum Tipo {
	DANO,
	ALCANCE,
	VELOCIDADE
}

@export var nome: String
@export var descricao: String
@export var sprite: CompressedTexture2D
@export var tipo: Tipo
@export var valor: float
