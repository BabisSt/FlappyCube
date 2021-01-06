extends KinematicBody2D

const UP = Vector2(0,-1)
const FLAP = 250
const MAXFALLSPEED = 250
const GRAVITY = 10

var motion = Vector2()
var Wall = preload("res://Walls.tscn")
var score = 0



var Wall_1 = Color("#26ADD3")
var B_1 = Color("#ff9a3c")
var Player_1 = Color("#939b62")


var Wall_2 = Color("#3ec1d3")
var B_2 = Color("#ff9a00")
var Player_2 = Color("#ff165d")

onready var fade = $Fade/AnimationPlayer
onready var fade_v = $Fade
onready var sprite = $Sprite
onready var audio = $AudioStreamPlayer
onready var audio_10 = $Score_10
onready var player = $CollisionShape2D



func _physics_process(delta):
	motion.y +=GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y =  MAXFALLSPEED
	
	if Input.is_action_just_pressed("FLAP"):
		motion.y  = -FLAP
		audio.play()
	if Input.is_action_just_pressed("Reload"):
		get_tree().reload_current_scene()
	
	if player.global_transform.origin.y > 450 or player.global_transform.origin.y < -450 :
		get_tree().reload_current_scene()
	motion = move_and_slide(motion,UP)
	
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)

func Wall_reset():
	var Wall_instance = Wall.instance()
	Wall_instance.position = Vector2(550,rand_range(-80,80))
	get_parent().call_deferred("add_child",Wall_instance)
	if score >= 10 and score < 20:
		Wall_instance.modulate = Color("#adccc7")
	elif score >= 20 and score < 30:
		Wall_instance.modulate = Color("#e71d36")
	elif score >= 30 and score < 40:
		Wall_instance.modulate = Color("#00f5d4")
	elif score >= 40 and score < 50:
		Wall_instance.modulate = Color("#d68c45")
	elif score >= 50 and score < 60:
		Wall_instance.modulate = Color("#ce2029")
	elif score >= 60 and score < 70:
		Wall_instance.modulate = Color("#c44900")
	elif score >= 70 and score < 80:
		Wall_instance.modulate = Color("#2e294e")
	elif score >= 80 and score < 90:
		Wall_instance.modulate = Color("#292f36")
	elif score >= 90 and score < 100:
		Wall_instance.modulate = Color("#faf0ca")


func _on_Resseter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()


func _on_HitBox_area_entered(area):
	if area.name == "PointArea":
		score +=1
		set_color(score)
		if score > HighScore.read_savegame():
			HighScore.save(score)



func _on_HitBox_body_entered(body):
	if body.name == "Walls":
		get_tree().reload_current_scene()
	

func set_color(score):
	if score >= 10 and score < 20:
		sprite.modulate = Color("#d34c26")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#d34c26")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#053220")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#d34c26")
	
	elif score >= 20 and score < 30:
		sprite.modulate = Color("#011627")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#011627")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#011627")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#ff9f1c")

	elif score >= 30 and score < 40:
		sprite.modulate = Color("#f15bb5")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#f15bb5")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#f15bb5")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#fee440")

	elif score >= 40 and score < 50:
		sprite.modulate = Color("#006400")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#006400")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#006400")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#ffc9b9")

	elif score >= 50 and score < 60:
		sprite.modulate = Color("#da9100")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#da9100")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#da9100")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#0047ab")

	elif score >= 60 and score < 70:
		sprite.modulate = Color("#183a37")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#183a37")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#183a37")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#432534")

	elif score >= 70 and score < 80:
		sprite.modulate = Color("#c5d86d")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#c5d86d")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#c5d86d")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#d7263d")

	elif score >= 80 and score < 90:
		sprite.modulate = Color("#f7fff7")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#f7fff7")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#f7fff7")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#292f36")

	elif score >= 90 and score < 100:
		sprite.modulate = Color("#0d3b66")
		get_parent().get_parent().get_node("CanvasLayer/HighScore").modulate = Color("#0d3b66")
		get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").modulate = Color("#0d3b66")
		get_parent().get_parent().get_node("Sprite").modulate = Color("#f95738")



	if score %10 == 0 :
		audio_10.play()



func _on_AnimationPlayer_animation_finished(anim_name):
	yield(get_tree().create_timer(2), "timeout")
