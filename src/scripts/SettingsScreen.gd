extends Control

func _on_Yes_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
	var _return = get_tree().change_scene("res://src/game/TitleScreen.tscn")
	pass

func _on_No_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	var _return = get_tree().change_scene("res://src/game/TitleScreen.tscn")
	pass
