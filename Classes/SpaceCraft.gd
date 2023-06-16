extends CharacterBody2D

class_name SpaceCraft

@export var torpedos: int = 50
@export var thrust_power: int = 100
@export var rotation_speed: float = 3
@export var life := 3
@export var max_velocity: Vector2 = Vector2(1000,1000)
@export var max_thrust_velocity: Vector2 = Vector2(100,100)

var current_direction := Vector2.ZERO
var current_rotation := 0.0
var is_gravity_active := false
var gravity_center := Vector2.ZERO
var gravity_power := 0.0
var can_shoot: bool = true

var shoot_timer: Timer

@onready var explosion_scn = preload("res://Objects/explosion.tscn")

signal torpedo_fired
signal death
signal torpedo_hit


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 1
	shoot_timer.connect("timeout", _on_can_shoot_again)
	add_child(shoot_timer)

func _physics_process(delta):
	check_for_screen_presence()
	if is_gravity_active and abs(velocity) < max_velocity:
		calculate_final_velocity(delta)
			
	move_and_slide()
	
func calculate_thrust_direction(from, target):
	current_direction = target.global_position - from.global_position
	current_direction = current_direction.normalized()
	if abs(velocity) < max_thrust_velocity:
		velocity += current_direction * thrust_power/100
	


func check_for_screen_presence():
	var screen_size = get_viewport_rect().size
	position.x = fposmod(position.x, screen_size.x)
	position.y = fposmod(position.y, screen_size.y)


func fire(_group_to_kill):
	if torpedos > 0 and can_shoot:
		torpedos -= 1
		can_shoot = false
		shoot_timer.start()
		emit_signal("torpedo_fired", self, _group_to_kill)


func activate_gravity(_is_gravity_active, _gravity_center, _gravity_power):
	is_gravity_active = _is_gravity_active
	gravity_center = _gravity_center
	gravity_power = _gravity_power


func calculate_final_velocity(delta):
	var dir = gravity_center - position
	velocity += dir.normalized() * gravity_power * delta

func hit():
	life -= 1
	emit_signal("torpedo_hit")
	if life <=0 :
		destroy()


func destroy():
	var e = explosion_scn.instantiate()
	emit_signal("death", e, transform)
	queue_free()
	
func _on_can_shoot_again():
	can_shoot = true
	
