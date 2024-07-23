params ["_vehicle"];

private _ropesCrane = _vehicle getVariable ["gradTnT_bpz_ropesCrane", []];
private _ropesHook = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];
private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];

{
	_x params ["_rope"];
	ropeDestroy _rope;
} forEach _ropesCrane;

{
    _x params ["_rope"];
    ropeDestroy _rope;
} forEach _ropesHook;


if (isNull _hook) then {
    detach _hook;
    deleteVehicle _hook;
};

