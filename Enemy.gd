extends KinematicBody2D

var motion = Vector2()
var blood_prefab = load("res://Blood.tscn")

func _ready():
	pass
	
func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	
	position += (Player.position - position) / 50
	look_at(Player.position)

	move_and_collide(motion)


func _on_Area2D_body_entered(body):
	if "Bullit" in body.name:
		var blood = blood_prefab.instance()
		get_tree().current_scene.add_child(blood)
		blood.global_position = global_position
		blood.rotation = global_position.angle_to_point(Global.player.global_position)
		queue_free()
