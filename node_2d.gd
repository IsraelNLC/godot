extends Node2D

var teammates := []
var enemies := []
var frontTeammate = 0
var frontEnemy = 0

@onready var enemy_scene = preload("res://creature.tscn")
@onready var posMiddle := Vector2(get_viewport_rect().size.x/2 ,get_viewport_rect().size.y/2)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_team()
	spawn_enemies()
	for creature in teammates:
		creature.defeated_signal.connect(next_in_front)
	for creature in enemies:
		creature.defeated_signal.connect(next_in_front)

func spawn_team(): # Crie Aliados e adicione-os à cena
	var position = 500
	for i in range(3):
		var new_creature = enemy_scene.instantiate()
		new_creature.hp = randi() % 100 + 50  # Defina HP aleatório entre 50 e 150
		new_creature.shield = randi() % 20 + 5  # Defina escudo aleatório entre 5 e 25
		new_creature.position = Vector2(position, 300)  # Posição aleatória na tela
		new_creature.speed = randi() % 10 + 1 # Velocidade aleatória para uma criatura  
		position -= 150
		add_child(new_creature)  # Adicione um aliado à cena
		teammates.append(new_creature)

func spawn_enemies(): # Crie inimigos e adicione-os à cena
	var position = 700
	for i in range(3):
		var new_creature = enemy_scene.instantiate()
		new_creature.hp = randi() % 100 + 50  # Defina HP aleatório entre 50 e 150
		new_creature.shield = randi() % 20 + 5  # Defina Ataque aleatório entre 5 e 25
		new_creature.position = Vector2(position, 300)  # Posição aleatória na tela
		new_creature.speed = randi() % 10 + 1 # Velocidade aleatória para uma criatura 
		position += 150
		add_child(new_creature)  # Adicione um inimigo à cena
		enemies.append(new_creature)

# Função para atacar um inimigo específico
func attack_creature_by_index(side, _index: int, damage: int):
	if _index >= 0 and _index < side.size():
		var enemy = side[_index]
		enemy.take_damage(damage)

func next_in_front(defeated_creature):
	if defeated_creature in teammates:
		frontTeammate += 1
	if defeated_creature in enemies:
		frontEnemy += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
#	checkIfAlive(teammates, frontTeammate)
#	checkIfAlive(enemies, frontEnemy)
	attack_creature_by_index(teammates,frontTeammate,20)
	attack_creature_by_index(enemies,frontEnemy,20)
