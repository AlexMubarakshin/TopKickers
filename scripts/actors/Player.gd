extends KinematicBody2D

export var MOTION_SPEED = 140
export var ATTACK_BLOW = 20
export var DAMAGE = 0.4

onready var speed = 0
onready var direction = Vector2(0,1)

var bullet_scene = preload("res://scenes/others/bullet.tscn")
onready var game = get_parent()

func _ready():
	pass


func shoot():
	var vct = get_global_mouse_position() - get_position()
	var bullet = bullet_scene.instance()
	bullet.initialize(DAMAGE,
		vct.normalized().rotated(rand_range(deg2rad(-5), deg2rad(5))),
		position, 
		ATTACK_BLOW, 
		speed * direction)
	
	game.add_child(bullet)


func _process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
		
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
			
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
		
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
	
	if Input.is_action_pressed("ui_mouse_left"):
		shoot()

	motion = motion.normalized() * MOTION_SPEED * delta
	move_and_collide(motion)
	
	direction = motion