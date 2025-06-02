extends Control

func _ready():
	# Connect tombol-tombol
	$VBoxContainer/play.connect("pressed", Callable(self, "_on_play_pressed"))
	$VBoxContainer/options.connect("pressed", Callable(self, "_on_options_pressed"))
	$VBoxContainer/quit.connect("pressed", Callable(self, "_on_quit_pressed"))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_options_pressed():
	print("Options clicked!")

func _on_quit_pressed():
	get_tree().quit()
