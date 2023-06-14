extends SpaceCraft

@onready var torpedo = load("res://Objects/torpedo.tscn") 

@onready var thrust_animation = $Thrust
@onready var engine_sprite = $Engine
@onready var target_sprite = $Target

func _ready():
	super._ready()
	connect("torpedo_hit", _on_hit_by_torpedo)

func _physics_process(delta):
	super._physics_process(delta)

	if Input.is_action_pressed("Thrust_P2"):
		thrust_animation.play("thrust")
		calculate_thrust_direction(engine_sprite, target_sprite)
		
	if Input.is_action_pressed("Left_P2"):
		rotation += -rotation_speed * delta
		
	if Input.is_action_pressed("Right_P2"):
		rotation += rotation_speed * delta
		
	if Input.is_action_just_pressed("Fire_P2"):
		fire("player_1")


func _on_hit_by_torpedo():
	$HitAnimation.play("hit")

func _unhandled_input(event):
	if Input.is_action_just_released("Thrust_P2"):
		thrust_animation.play("idle")


func _on_death_zone_body_entered(body):
	if body.is_in_group("player_1"):
		body.destroy()
		get_tree().call_group_flags(0, "player_2", "destroy")
