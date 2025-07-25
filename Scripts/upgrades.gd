extends VBoxContainer

const UpgradeScene = preload("res://Scenes/upgrade.tscn");

var upgrades_data;

func _ready():
	upgrades_data = read_upgrades_json();
	
	## starting user with 4 upgrades
	for i in range(4):
		show_new_upgrade();
		
func show_new_upgrade():
	var data = upgrades_data.pop_front(); ## remove upgrade from data
	var upgrade = UpgradeScene.instantiate()
	upgrade.upgrade_name = data["name"];
	upgrade.upgrade_cost = data["cost"];
	upgrade.type = upgrade.upgrade_type.CLICK_UPGRADE if data["type"] == "click" else upgrade.upgrade_type.GPS_UPGRADE;
	upgrade.upgrade_value = data["value"];
	add_child(upgrade);
	

func read_upgrades_json():
	var file = FileAccess.open("res://Data/upgrades.json", FileAccess.READ); ## opening json file
	
	var raw_data = file.get_as_text();
	file.close();
	
	var json = JSON.new();
	var upgrades_data = json.parse(raw_data); ## turning raw json string into real data
	
	return json.get_data();
