params ["_position", "_size", ["_isSecondDepot", false]];

// make sure this runs when clients hit the ammo depots
if (!isServer) exitWith {
	[[_position, _size, _isSecondDepot], "user\scripts\ammo.sqf"] remoteExec ["BIS_fnc_execVM", 2];
};

private _ammoContainers = nearestObjects [_position, ["Land_Cargo20_military_green_F"], 200];

{
	private _position = getPosATL _x;
	private _dir = getDir _x;
	deleteVehicle _x;
	
	// only lower containers shall be replaced
	if (_position#2 < 1) then {
		private _ruin = "Land_Cargo20_military_ruins_F" createVehicle [0,0,0];
		_ruin setPosATL _position;
		_ruin setDir _dir;
	};
	
} forEach _ammoContainers;

private _identifier = format ["grad_ammodump_exploded_%1", _isSecondDepot];

if (missionNameSpace getVariable [_identifier, false]) exitWith {};
missionNamespace setVariable [_identifier, true, true];

private _pos = +_position;
[[_pos, _size], "user\scripts\luna.sqf"] remoteExec ["BIS_fnc_execVM"];


[_position] spawn {
	params ["_ammoPos"];

	for "_i" from 0 to 15 do {
		private _ammo = "gm_rocket_luna_he_3r9" createVehicle _ammoPos;
		// _ammoPos set [2, 100];
		_ammo setPos _ammoPos;
        // _ammo setVectorUp [0,0,-1];
		_ammo setVelocity [0, 0, -200];
		sleep (random 1 max 0.25);
	};
};

