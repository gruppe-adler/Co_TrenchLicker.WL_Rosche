{
	private _tooth = _x;
	private _posATL = (getPosATL _tooth);
	private _actionDummy = "Sign_Sphere10cm_F" createVehicleLocal _posATL;
	_actionDummy setObjectTexture [0,"#(rgb,8,8,3)color(0,0,0,0)"];
	_actionDummy setPosATL _posATL;
	
	private _action = ["AttachExplosive", "Attach Explosive", "\A3\ui_f\data\igui\cfg\actions\arrow_down_gs.paa", {
		params ["_target", "_player", "_args"];
		_args params ["_tooth", "_posATL"];

		// systemchat str _posATL;

		 [3, [_tooth, _posATL], {
			params ["_args"];
			_args params ["_tooth", "_posATL"];

			// systemchat str _args;
			
			"Exploding in 10s..." call CBA_fnc_notify;
			[{
				params ["_tooth", "_posATL"];

				// systemchat str _posATL;
				private _type = typeOf _tooth;
				private _posASL = (ATLToASL _posATL);
				private _posAGL = (ASLtoAGL _posASL);

				private _ammo = "gm_uxo_m77" createVehicle (_posAGL);
				_ammo setDamage 1;
				[[_type, _posAGL], "user\scripts\dragontooth_clearLocally.sqf"] remoteExec ["execVM", 0, true];

			}, [_tooth, _posATL], 10] call CBA_fnc_waitAndExecute;		

		}, {
			"Aborted Explosive attachment" call CBA_fnc_notify;
		}, "Laying Explosive..."] call ace_common_fnc_progressBar;


	}, {
			true
	}, nil, [_tooth, _posATL], [0,0,1.2]] call ace_interact_menu_fnc_createAction;


	[_actionDummy, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

} foreach allSimpleObjects ["Land_DragonsTeeth_01_1x1_old_F"];