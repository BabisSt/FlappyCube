extends Node2D

onready var fade = $Fade/AnimationPlayer
onready var change_colors = $ColorRect/AnimationPlayer

func _ready():
	change_colors.play("change color")
	

func _on_Button_pressed():
	fade.play("fade_out")
	_on_AnimationPlayer_animation_finished("fade_out")

func _on_Quit_pressed():
	get_tree().quit()


func _on_AnimationPlayer_animation_finished(anim_name):
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://World.tscn")
