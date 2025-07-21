extends Control

var trees: int = 0; ## game score
var current_tree_growth: float = 0; ## value 0-100. at 100 trees increments
var growth_per_click: float = 5; ## tree progress per click
var growth_per_second: float = 0; ## automatic tree progress per second

func _ready() -> void:
	$TreeClicker.connect("pressed", _on_tree_clicked);
	
	for upgrade in $UpgradesVBox.get_children():
		upgrade.connect("upgrade_requested", _on_upgrade_requested)
	
func _on_tree_clicked():
	## adding progress to tree
	current_tree_growth += growth_per_click;
	
	## increasing score and resetting tree once complete
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
		
	update_values_in_UI();
	
	## function to update trees, gps, etc on the UI
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
			
	update_values_in_UI();
