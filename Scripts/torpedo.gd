extends Area2D

@export var speed: float = 500
@onready var screen_size = get_viewport_rect().size

var group_to_kill := "player_2"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += transform.x * speed * delta
	if position.x > screen_size.x or position.y > screen_size.y or position.x < 0 or position.y < 0:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group(group_to_kill):
		print("Just Hit " + group_to_kill)
		body.hit()
		queue_free()
