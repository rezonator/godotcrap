extends KinematicBody2D

const MOVESPEED = 500
const BULLET_SPEED = 2000
const bullet_prefab = preload("res://Bullit.tscn") 
const shake_amount = 1.0

func _ready():
	Global.player = self
	pass
	
func _exit_tree():
	Global.player = null

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
		
	if Input.is_action_just_pressed("fire"):
		fire()

	motion = motion.normalized()
	motion = move_and_slide(motion * MOVESPEED)
	
	look_at(get_global_mouse_position())
	
func fire():
	var bullet_instance = bullet_prefab.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(BULLET_SPEED, 0).rotated(rotation))
	#instantiate a bullet
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	#shake
	$Camera2D.shake(0.2,15,8)
	



func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		get_tree().reload_current_scene()
