extends Control

var trees: int = 0; ## game score
var current_tree_growth: float = 0; ## value 0-100. at 100 trees increments
var growth_per_click: float = 1; ## tree progress per click
var growth_per_second: float = 0; ## automatic tree progress per second

func _ready() -> void:
	$TreeClicker.connect("pressed", _on_tree_clicked);
	
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
		
	$InfoPanel/MarginContainer/VBoxContainer/VBoxContainer2/TreeGrowthProgress.value = current_tree_growth; ## updating tree progress bar
