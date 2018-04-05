extends Node2D

const SLOWDOWN = 0.99
const BULLET_START_SPEED = 1500
var ATTACK_BLOW
var DAMAGE
var dir
var initialized = false
var tot_st_spd

func destroy():
	queue_free()

func initialize(dmg1, direction, pos, blow, inherent_speed_vect):
	position = pos
	dir = direction * BULLET_START_SPEED + inherent_speed_vect
	tot_st_spd = dir.length()
	set_rotation(atan2(dir.y, dir.x) + deg2rad(90))
	
	DAMAGE = dmg1
	ATTACK_BLOW = blow
	initialized = true
	
func hit(object):
	if object.is_in_group('Enemies'):
		object.get_damage(DAMAGE, position, ATTACK_BLOW)
	
	if !object.is_in_group('MainPlayer'):
		destroy()


func _physics_process(delta):
	if initialized:
		translate(dir * delta)
		if dir.length() < 0.4 * tot_st_spd:
			destroy()
		dir *= SLOWDOWN

func _on_Area2D_body_entered(body):
	hit(body)
