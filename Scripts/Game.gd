extends Control

var trees: int = 0; ## game score
var current_tree_growth: float = 0; ## value 0-100. at 100 trees increments
var growth_per_click: float = 1; ## tree progress per click
var growth_per_second: float = 0; ## automatic tree progress per second

const TreeClickLabel = preload("res://Scenes/tree_click_label.tscn");

func _ready() -> void:
	$TreeClicker.connect("pressed", _on_tree_clicked);
	$GPSTimer.connect("timeout", _on_gpstimer_timeout);
	
	## connect all existing upgrades to parent function
	for upgrade in $UpgradesVBox.get_children():
		upgrade.connect("upgrade_requested", _on_upgrade_requested);
		
func get_tree_rotation_bounds() -> Vector2i:
	if current_tree_growth < 20:
		return Vector2i(5, 15);
	elif current_tree_growth < 40:
		return Vector2i(4, 10);
	elif current_tree_growth < 60:
		return Vector2i(3, 6);
	elif current_tree_growth < 80:
		return Vector2i(2, 3);
	else:
		return Vector2i(1, 1);
	
func _on_tree_clicked():
	## playing tree shake animation when sprite is clicked
	var rotation_tween := create_tween();
	## calculating angles to rotate tree during animation
	var rotation_bounds := get_tree_rotation_bounds();
	var right_rotation := randi_range(rotation_bounds[0], rotation_bounds[1]);
	var left_rotation := randi_range(rotation_bounds[0] * -1, rotation_bounds[1] * -1);
	var initial_direction := randi_range(0, 1); ## rotates left first if 0, right if 1
	## playing animation
	rotation_tween.tween_property($TreeClicker, "rotation_degrees", right_rotation if initial_direction == 1 else left_rotation, randf_range(0.04, 0.06));
	rotation_tween.tween_property($TreeClicker, "rotation_degrees", right_rotation if initial_direction == 0 else left_rotation, randf_range(0.12, 0.2));
	rotation_tween.tween_property($TreeClicker, "rotation_degrees", 0, 0.2);
	
	## showing label indicator when tree is clicked of growth added (e.g: +1)
	var growth_label := TreeClickLabel.instantiate();
	growth_label.text = "+%.1f" % [growth_per_click] + "%";
	## randomising where to display label
	var growth_label_x_pos := randi_range(size.x/2 - 72, size.x/2 + 60);
	var growth_label_y_pos := randi_range(size.y - ($TreeClicker.size.y * 4.5) - 96, size.y - ($TreeClicker.size.y * 2.5) - 12);
	growth_label.position = Vector2i(growth_label_x_pos, growth_label_y_pos);
	add_child(growth_label);
	## animating label to scale in, then fade out
	var label_tween := create_tween();
	label_tween.tween_property(growth_label, "scale", Vector2(1, 1), 0.2).from(Vector2(0.8, 0.8));
	label_tween.tween_property(growth_label, "modulate:a", 0, 0.8);
	
	## adding progress to tree
	current_tree_growth += growth_per_click;
	
	update_tree_growth();
	update_values_in_UI();
	
func _on_gpstimer_timeout():
	if growth_per_second > 0:
		current_tree_growth += growth_per_second;
		update_tree_growth();
		update_values_in_UI();
		
## checking if tree growth at checkpoint/complete
func update_tree_growth():
	if current_tree_growth >= 100:
		current_tree_growth -= 100;
		trees += 1;
		$InfoPanel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/TreeCount.text = str(trees); ## updating trees score text
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak1.png");
		$TreeClicker.pivot_offset = Vector2(8, 13);
	elif current_tree_growth >= 80:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak5.png");
		$TreeClicker.pivot_offset = Vector2(24, 87);
	elif current_tree_growth >= 60:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak4.png");
		$TreeClicker.pivot_offset = Vector2(23, 63);
	elif current_tree_growth >= 40:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak3.png");
		$TreeClicker.pivot_offset = Vector2(12, 32);
	elif current_tree_growth >= 20:
		$TreeClicker.texture_normal = preload("res://Assets/Trees/Oak2.png");
		$TreeClicker.pivot_offset = Vector2(8, 19);
	
## update trees, gps, etc on the UI
func update_values_in_UI():
	$InfoPanel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/TreeCount.text = str(trees); ## trees
	$InfoPanel/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer2/GPS.text = str(growth_per_second); # gps
	$InfoPanel/MarginContainer/VBoxContainer/VBoxContainer2/TreeGrowthProgress.value = current_tree_growth; ## tree progress bar

func _on_upgrade_requested(upgrade: Upgrade):
	## if can afford upgrade
	if upgrade.upgrade_cost <= trees:
		trees -= upgrade.upgrade_cost; ## removing cost from trees
		
		## increasing value upgrade gives
		if upgrade.type == upgrade.upgrade_type.CLICK_UPGRADE:
			growth_per_click += upgrade.upgrade_value;
		elif upgrade.type == upgrade.upgrade_type.GPS_UPGRADE:
			growth_per_second += upgrade.upgrade_value;
		
		upgrade.queue_free(); ## delete upgrade node from scene
			
	update_values_in_UI();
