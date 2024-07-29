params ["_vehicle"];

_vehicle addEventHandler ["HandleDamage",{
	params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
	// _hitPoint == "hithull" &&
	
	private _previousdamage = _unit getHitPointDamage _hitPoint;
	if (_previousdamage + _damage > 0.8 && (_hitpoint in ["hithull"] || _hitpoint == "")) then {
		_damage = 0.8;
		// systemchat (("limited to damage: ") + str _damage);
		
		// add random hit to another uncritical component
		private _selection = selectRandom 
		["hitengine",
		"hitfuel",
		"hitltrack",
		"hitrtrack",
		"hitturret",
		"hitgun",
		"hitcomturret",
		"hitcomgun"];

		[_unit, _selection, 1] call BIS_fnc_setHitPointDamage;
	};
	
	// systemchat (("end damage: ") + str _damage + "hitpoint: " + str _hitpoint);
	_damage
}];

/*

[["hithull","hitengine","hitfuel","hitltrack","hitrtrack","hitslat_left_1","hitslat_left_2","hitslat_left_3","hitslat_right_1","hitslat_right_2","hitslat_right_3","hitslat_top_back","hitslat_top_left","hitslat_top_right","hitslat_back","hitslat_front","hitturret","hitgun","hitcomturret","hitcomgun","#light_l","#light_l_flare","#light_r","#light_r_flare"],["hit_hull_point","hit_engine_point","hit_fuel_point","hit_trackl_point","hit_trackr_point","cage_left_1_point","cage_left_2_point","cage_left_3_point","cage_right_1_point","cage_right_2_point","cage_right_3_point","cage_top_back_point","cage_top_left_point","cage_top_right_point","cage_back_point","cage_front_point","hit_main_turret_point","hit_main_gun_point","hit_com_turret_point","hit_com_gun_point","light_l","light_l_flare","light_r","light_r_flare"],[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]

*/