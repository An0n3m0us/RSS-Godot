extends Control

# Intro
var introSkip = false
var logoScale = 0
var fade = 0
var fadein = 1

func _ready():
	logoScale = $Logo.scale
	fade = $Fade.color
	#GlobalAudio.get_node("Tokyo-bells").play()
	pass
	
func _process(_delta):
	if logoScale[0] < 1:
		logoScale[0] += 0.001
		logoScale[1] += 0.001
		$Logo.scale = Vector2(logoScale[0], logoScale[1])
	
	if fade[3] > 0:
		fade[3] -= 0.003
		$Fade.color = fade
	else:
		if fadein > 0:
			$Background.color = Color(0, 0, 0, fadein)
			$Logo.modulate[3] = fadein
			$Fade.visible = false
			fadein -= 0.02
		else:
			get_tree().change_scene("res://src/game/TitleScreen.tscn")
	pass

func _on_Fade_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				get_tree().change_scene("res://src/game/TitleScreen.tscn")
	pass
