extends Node2D

onready var music = $AudioStreamPlayer
onready var highScore = $CanvasLayer/HighScore
onready var cd = $CanvasLayer/CountDown
onready var fade = $PlayerNode/Player/Fade/AnimationPlayer

var timer= 3.0

func _ready():
	randomize()
	#music.play()
	highScore.text = str("Highscore: " ,HighScore.read_savegame())
	get_tree().paused = true
	#fade.play("fade_in")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().paused = false

func _physics_process(delta):
	if Input.is_action_just_pressed("FLAP"):
		$CanvasLayer/inputs.visible = false
	#if Input.is_action_just_pressed("ui_cancel"):
	#	get_tree().paused = true
	#	if Input.is_action_just_pressed("FLAP"):
	#		get_tree().paused = false
