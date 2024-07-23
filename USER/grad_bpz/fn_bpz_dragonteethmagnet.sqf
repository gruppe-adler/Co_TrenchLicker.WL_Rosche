params ["_vehicle"];


private _pfh = [{
	params ["_args", "_handle"];
	_args params ["_vehicle"];

	if (isNull (_vehicle getVariable ["grad_bpz_magnetAttached", objNull])) then {
		private _hook = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];

		if (count _hook > 0) then {
			private _hookObj = _hook#0#2;
			private _positionHookASL = getPosASL _hookObj;
			private _nearestDragonTooth = lineIntersectsWith [_positionHookASL, _positionHookASL vectorAdd [0,0,-1], _hookObj];
			// allSimpleObjects ["Land_DragonsTeeth_01_1x1_old_F"] inAreaArray [ASLToAGL (getPosASL (_hook#0#2)), 1.5,1.5];
			// lineIntersectsWith [eyePos player, AGLToASL screenToWorld [0.5, 0.5]];
			 // nearestObjects [ASLToAGL (getPosASL (_hook#0#2)), ["Land_DragonsTeeth_01_1x1_old_F"], 0.5];

			if (count _nearestDragonTooth > 0 && typeOf (_nearestDragonTooth#0) == "Land_DragonsTeeth_01_1x1_old_F") then {
				[_positionHookASL, _hookObj] remoteExec ["grad_bpz_fnc_bpz_deleteToothLocally", 0, true];

				private _toothGlobal = "Land_DragonsTeeth_01_1x1_old_F" createVehicle [0,0,0];
				private _physXhelper = "Land_Can_V2_F" createVehicle [0,0,0];
				_physXhelper setMass 0.05;

				{
					_x params ["_rope"];
					private _index = _forEachIndex + 1;
					private _attachpoint = [0,0,0];
					switch (_index) do {
						case 1: { _attachpoint = [0.2, 0.2, 0]; };
						case 2: { _attachpoint = [-0.2, 0.2, 0]; };
						case 3: { _attachpoint = [-0.2, -0.2, 0]; };
						case 4: { _attachpoint = [0.2, -0.2, 0]; };
						default { };
					};

					[_physXhelper, _attachpoint, [0,0,-1]] ropeAttachTo _rope;
				} forEach _hook;

				[{ 
					params ["_toothGlobal", "_physXhelper"];

					_toothGlobal attachTo [_physXhelper, [0,0,0]];

				}, [_toothGlobal, _physXhelper]] call CBA_fnc_execNextFrame;

				_vehicle setVariable ["grad_bpz_magnetAttached", _physXhelper, true];
				_vehicle setVariable ["grad_bpz_toothGlobal", _toothGlobal, true];

				"Attached Dragon tooth. Press FIRE to drop." call CBA_fnc_notify;
			};
		};
	};

}, 0.1, [_vehicle]] call CBA_fnc_addPerFrameHandler;


[{
	params ["_vehicle"];
	!(_vehicle getVariable ["gradTnT_recoveryMode", false])
},{
	params ["_vehicle", "_pfh"];

	[_pfh] call CBA_fnc_removePerFrameHandler;

}, [_vehicle, _pfh]] call CBA_fnc_waitUntilAndExecute;