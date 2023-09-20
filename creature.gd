extends Node2D

signal defeated_signal(creature)

# Propriedades do inimigo
var hp : int
var shield : int
var speed : int
var shieldOn : bool
# Nodes
@onready var hpLabel := $HP
@onready var shieldLabel := $SHIELD

func _ready():
	update_infos()
#	Código para reinforced shield.
#	if shield > 0:
#		shieldOn = true

# Método para causar dano ao inimigo
func take_damage(damage: int):
	shield -= damage
	if shieldOn == false:
		hp -= damage
	if shield <= 0:
		shield = 0
		shieldOn = false
	if hp <= 0:
		die()
	update_infos()

func update_infos():
	hpLabel.text = str(hp)
	shieldLabel.text = str(shield)

# Método para lidar com a morte do inimigo
func die():
	emit_signal("defeated_signal", self)
	queue_free()  # Remove o inimigo do jogo
