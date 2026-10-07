extends Resource
class_name StatusMagia

enum Tipo {
	DANO,
	ALCANCE,
	VELOCIDADE,
	CURA
}

enum Raridade {
	COMUM,
	INCOMUM,
	RARA
}

@export var nome: String
@export var descricao: String
@export var sprite: CompressedTexture2D
@export var tipo: Tipo
@export var raridade: Raridade
@export var preco: float
@export var valor: float
