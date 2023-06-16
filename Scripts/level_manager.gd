extends Node2D

@onready var torpedo_scn = preload("res://Objects/torpedo.tscn")

func _enter_tree():
	$SpaceCrafts/Player1Craft.connect("torpedo_fired", _on_player1_torpedo_fired)
	$SpaceCrafts/Player2Craft.connect("torpedo_fired", _on_player1_torpedo_fired)
	$SpaceCrafts/Player1Craft.connect("death", _on_player1_dead)
	$SpaceCrafts/Player2Craft.connect("death", _on_player1_dead)


func _on_player1_torpedo_fired(obj,_group_to_kill):
	var t = torpedo_scn.instantiate()
	$Torpedos.add_child(t)
	t.scale = Vector2.ONE * 0.3
	t.transform = obj.transform
	t.group_to_kill = _group_to_kill



func _on_player1_dead(obj, _transform):
	$Explosions.add_child(obj)
	obj.transform = _transform
	$Timer.start()


func _on_timer_timeout():
	get_tree().reload_current_scene()
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
