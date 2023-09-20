#extends KinematicBody2D
#
## Propriedades do inimigo
#var hp : int = 100
#var attack : int = 10
#
## Método para causar dano ao inimigo
#func take_damage(damage: int):
#	hp -= damage
#	if hp <= 0:
#		die()
#
## Método para lidar com a morte do inimigo
#func die():
#	queue_free()  # Remove o inimigo do jogo
