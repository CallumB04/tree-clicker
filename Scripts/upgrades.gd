extends VBoxContainer

const UpgradeScene = preload("res://Scenes/upgrade.tscn");

func _ready():
	var data = read_upgrades_json();
	
	for upgrade_data in data:
		var upgrade = UpgradeScene.instantiate()
		upgrade.upgrade_name = upgrade_data["name"];
		upgrade.upgrade_cost = upgrade_data["cost"];
		upgrade.type = upgrade.upgrade_type.CLICK_UPGRADE if upgrade_data["type"] == "click" else upgrade.upgrade_type.GPS_UPGRADE;
		upgrade.upgrade_value = upgrade_data["value"];
		add_child(upgrade);

func read_upgrades_json():
	var file = FileAccess.open("res://Data/upgrades.json", FileAccess.READ); ## opening json file
	
	var raw_data = file.get_as_text();
	file.close();
	
	var json = JSON.new();
	var upgrades_data = json.parse(raw_data); ## turning raw json string into real data
	
	return json.get_data();
	
