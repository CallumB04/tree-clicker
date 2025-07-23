extends PanelContainer

class_name Upgrade

signal upgrade_requested(upgrade: Upgrade);

enum upgrade_type {
	CLICK_UPGRADE,
	GPS_UPGRADE
};

## unique upgrade values
@export var upgrade_name: String;
@export var upgrade_description: String;
@export var upgrade_cost: int;
@export var type: upgrade_type;
@export var upgrade_value: float; ## value the upgrade adds (to growth per click/second, etc)

func _ready() -> void:
	## connecting buy button to upgrade script
	$MarginContainer/VBoxContainer2/BuyButton.connect("pressed", _on_buy_pressed);
	
	## adding unique values to UI
	$MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/UpgradeName.text = upgrade_name;
	$MarginContainer/VBoxContainer2/VBoxContainer/UpgradeDesc.text = upgrade_description;
	$MarginContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer/UpgradeCost.text = str(upgrade_cost);
	
	## changed description font color if click upgrade
	if type == upgrade_type.CLICK_UPGRADE:
		$MarginContainer/VBoxContainer2/VBoxContainer/UpgradeDesc.add_theme_color_override("font_color", "#ce3333")

func _on_buy_pressed():
	upgrade_requested.emit(self);
