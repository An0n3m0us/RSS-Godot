extends Node2D

var pos = []

func _ready():
	pos.append(get_node("Positions").get_child(0).position[1])
	pos.append(get_node("Positions").get_child(5).position[1])
	pos.append(get_node("Positions").get_child(10).position[1])
	loop(2)

onready var t = get_node("Timer")

func loop(sec):
	t.set_wait_time(sec)
	t.start()
	yield(t, "timeout")
	
	var scene = load("res://src/actors/Esquire-enemy.tscn")
	var player = scene.instance()
	player.name = self.name
	player.position = Vector2(1270, (randi()%3+1)*175-50)
	self.add_child(player)
	
	loop(sec)
