extends KinematicBody2D

export (String) var type
export (float) var healthMultiplier
export (int) var speed

var selected = false

var health = 10
var healthdeplete = false

func _physics_process(_delta):

	# Check if colliding with object
	if healthdeplete:
		health -= healthMultiplier

	update()

func _draw():
	# Health bar
	#if selected == true:	
	draw_rect(Rect2(self.get_node("Pivot").position[0]-24, self.get_node("Pivot").position[1]-60, 50, 5), Color8(100, 0, 0))
	draw_rect(Rect2(self.get_node("Pivot").position[0]-24, self.get_node("Pivot").position[1]-60, health*5, 5), Color8(255, 0 , 0))

func _on_Area2D_body_entered(body):
	if body.type != type:
		healthdeplete = true

func _on_Area2D_body_exited(body):
	if body.type != type:
		healthdeplete = false
