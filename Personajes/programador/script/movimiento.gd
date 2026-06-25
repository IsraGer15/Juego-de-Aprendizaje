extends CharacterBody2D

const SPEED: float = 100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_x: int = 0
var last_y: int = 1 

func _ready() -> void:
	animated_sprite.play("Indle_Down")


func _physics_process(_delta: float) -> void:
	var dir_x: int = int(Input.is_action_pressed("ui_right")) \
				  - int(Input.is_action_pressed("ui_left"))
	var dir_y: int = int(Input.is_action_pressed("ui_down")) \
				  - int(Input.is_action_pressed("ui_up"))

	var moving: bool = (dir_x != 0 or dir_y != 0)

	if moving:
		
		last_x = dir_x
		last_y = dir_y
		velocity = Vector2(dir_x, dir_y).normalized() * SPEED
		_play_animation(_walk_anim(dir_x, dir_y))
	else:
		velocity = Vector2.ZERO
		_play_animation(_idle_anim(last_x, last_y))

	move_and_slide()



func _walk_anim(x: int, y: int) -> String:
	if   x ==  0 and y ==  1: return "Walk_Down"
	elif x ==  0 and y == -1: return "Walk_Up"
	elif x ==  1 and y ==  0: return "Walk_Side_Rigth"
	elif x == -1 and y ==  0: return "Walk_Side_Left"
	elif x ==  1 and y ==  1: return "Walk_Down_Side_Rigth"
	elif x == -1 and y ==  1: return "Walk_Down_Side_Left"
	elif x ==  1 and y == -1: return "Walk_Up_Side_Rigth"
	elif x == -1 and y == -1: return "Walk_Up_Side_Left"
	return "Walk_Down"  



func _idle_anim(x: int, y: int) -> String:
	if   x ==  0 and y ==  1: return "Indle_Down"
	elif x ==  0 and y == -1: return "Idle_Up"
	elif x ==  1 and y ==  0: return "Idle_Side_Right"
	elif x == -1 and y ==  0: return "Idle_Side_Left"
	elif x ==  1 and y ==  1: return "Idle_Down_Side_Right"
	elif x == -1 and y ==  1: return "Idle_Down_Side_Left"
	elif x ==  1 and y == -1: return "Idle_Up_Side_Right"
	elif x == -1 and y == -1: return "Idle_Up_Side_Left"
	return "Indle_Down" 



func _play_animation(anim_name: String) -> void:
	if animated_sprite.animation != anim_name or not animated_sprite.is_playing():
		animated_sprite.play(anim_name)
