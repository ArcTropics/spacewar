extends Area2D

@export var speed: float = 500
@export var hit_range: float = 30

@onready var screen_size = get_viewport_rect().size
@onready var starting_position: Vector2 = position 

var group_to_kill := "player_2"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group(group_to_kill):
		body.hit()
		queue_free()


func _on_timer_timeout():
	queue_free()
