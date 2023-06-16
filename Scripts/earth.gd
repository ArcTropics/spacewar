extends CelestialBody2D


func _on_gravity_field_1_body_entered(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_1)


func _on_gravity_field_1_body_exited(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_2)


func _on_gravity_field_2_body_entered(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_2)


func _on_gravity_field_2_body_exited(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_3)


func _on_gravity_field_3_body_entered(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_3)


func _on_gravity_field_3_body_exited(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_4)


func _on_gravity_field_4_body_entered(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(true, position, gravity_power_4)


func _on_gravity_field_4_body_exited(body):
	if body.is_in_group("space_object"):
		body.activate_gravity(false, position, 0)


func _on_death_zone_body_entered(body):
	if body.is_in_group("space_object"):
		body.destroy()
