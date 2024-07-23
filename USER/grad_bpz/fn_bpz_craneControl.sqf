addUserActionEventHandler ["CarForward", "Activate", {
    
	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 0.75;
		private _anim = "crane_elev_source";
		private _source = _vehicle animationSourcePhase _anim;
		if (_source < _max) then {
			_vehicle animateSource [_anim, _max];
			[["Raising crane...", 1.5, [0, 1, 0, 1]], true] call CBA_fnc_notify;
		} else {
			[["Cant raise further.", 1.5, [1, 0, 0, 1]], true] call CBA_fnc_notify;
		};
	};
}];

addUserActionEventHandler ["CarForward", "DeActivate", {
    
	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 0.1;
		private _anim = "crane_elev_source";
		private _source = _vehicle animationSourcePhase _anim;
		_vehicle animateSource [_anim, _source];
		[["Stopped raising crane.", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;
	};
}];

addUserActionEventHandler ["CarBack", "Activate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 0.1;
		private _anim = "crane_elev_source";
		private _source = _vehicle animationSourcePhase _anim;
		if (_source > _max) then {
			_vehicle animateSource [_anim, _max];
			[["Lowering crane...", 1.5, [0, 1, 0, 1]], true] call CBA_fnc_notify;
		} else {
			[["Cant lower crane further.", 1.5, [1, 0, 0, 1]], true] call CBA_fnc_notify;
		};
	};	
}];


addUserActionEventHandler ["CarBack", "DeActivate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _anim = "crane_elev_source";
		private _source = _vehicle animationSourcePhase _anim;
		_vehicle animateSource [_anim, _source];
		[["Stopped lowering crane.", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;
	};	
}];

addUserActionEventHandler ["CarLeft", "Activate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 1;
		private _anim = "crane_trav_source";
		private _source = _vehicle animationSourcePhase _anim;
		if (_source < 1) then {
			_vehicle animateSource [_anim, _max];
			[["Turning crane left...", 1.5, [0, 1, 0, 1]], true] call CBA_fnc_notify;
		} else {
			[["Cant turn further left.", 1.5, [1, 0, 0, 1]], true] call CBA_fnc_notify;
		};
	};
}];

addUserActionEventHandler ["CarLeft", "DeActivate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 1;
		private _anim = "crane_trav_source";
		private _source = _vehicle animationSourcePhase _anim;
		_vehicle animateSource [_anim, _source];
		[["Stopped turning crane left.", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;
	};
}];

addUserActionEventHandler ["CarRight", "Activate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 0.1;
		private _anim = "crane_trav_source";
		private _source = _vehicle animationSourcePhase _anim;
		if (_source > 0.1) then {
			_vehicle animateSource [_anim, _max];
			[["Turning crane right...", 1.5, [0, 1, 0, 1]], true] call CBA_fnc_notify;
		} else {
			[["Cant turn further right...", 1.5, [1, 0, 0, 1]], true] call CBA_fnc_notify;
		};
	};
}];

addUserActionEventHandler ["CarRight", "DeActivate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {

		private _vehicle = vehicle player;
		private _max = 0.1;
		private _anim = "crane_trav_source";
		private _source = _vehicle animationSourcePhase _anim;
		_vehicle animateSource [_anim, _source];
		[["Stopped turning right", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;
	};
}];

addUserActionEventHandler ["CarFastForward", "Activate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {
		[["Retracting hook...", 1.5, [0, 1, 0, 1]], true] call CBA_fnc_notify;
		[vehicle player, false, false, 0.5] call grad_bpz_fnc_bpz_ropeUnwind;
	};
}];
addUserActionEventHandler ["CarFastForward", "DeActivate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {
		[["Stopped retracting hook.", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;
		[vehicle player, false, false, 0] call grad_bpz_fnc_bpz_ropeUnwind;
	};
}];

addUserActionEventHandler ["CarSlowForward", "Activate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {
		[["Unwinding hook...", 1.5, [0, 1, 0, 1]], true] call CBA_fnc_notify;
		[vehicle player, true, false, 7] call grad_bpz_fnc_bpz_ropeUnwind;
	};
}];

addUserActionEventHandler ["CarSlowForward", "DeActivate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {
		[["Stopped unwinding hook.", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;
		[vehicle player, false, false, 0] call grad_bpz_fnc_bpz_ropeUnwind;
	};
}];


private _ehRU = addUserActionEventHandler ["defaultAction", "Activate", { 

	if ([] call grad_bpz_fnc_bpz_isRecoveryMode) then {
		private _vehicle = vehicle player;
		private _object = _vehicle getVariable ["grad_bpz_magnetAttached", objNull];
		if (!isNull _object) then {

			private _ropes = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];
			{
				_object ropeDetach _x#0;
			} forEach _ropes;
			_vehicle setVariable ["grad_bpz_magnetAttached", objNull, true];
			[["Detached object.", 1.5, [1, 1, 1, 1]], true] call CBA_fnc_notify;

			[_object, "surrender_fall"] remoteExec ["say3D"];
		};
	};
}];
