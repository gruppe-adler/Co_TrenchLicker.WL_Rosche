/*

    ---> not used atm

*/

grad_bpz_fnc_canPickUpRopes = {
  !(player getVariable ["gradTnT_ropesPickedUp", false]) &&
  count (missionNamespace getVariable ["gradTnT_nearByRopes",[]] select 0) > 0 &&
  vehicle player == player
};

grad_bpz_fnc_canDropRopes = {
  player getVariable ["gradTnT_ropesPickedUp", false] &&
  vehicle player == player
};

grad_bpz_fnc_canAttachRopes = {
    player getVariable ["gradTnT_ropesPickedUp", false] &&
    count (nearestObjects [player, ["LandVehicle"], 5]) > 0
};



grad_bpz_fnc_attachRopes = {
    private _vehicles = nearestObjects [player, ["LandVehicle"], 5];
    private _vehicle = objNull;

    if (count _vehicles > 0) then {
        _vehicle = _vehicles select 0;

        private _originVehicle = player getVariable ["gradTnT_ropesVehicle", objNull];
        private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];
        private _helper = player getVariable ["gradTnT_ropesHelper", objNull];
        private _ropes = player getVariable ["gradTnT_ropes", []];

        player setVariable ["gradTnT_ropesPickedUp", false, true];
        _hook setVariable ["canHook", true, true];

        {
            _x params ["_rope"];
            player ropeDetach _rope;
        } forEach _ropes;

        deleteVehicle _helper;

        private _corners = [_vehicle] call grad_bpz_fnc_getCornerPoints;
        _vehicle setVariable ["gradTnT_originalMass", getMass _vehicle, true];
        _vehicle setMass 5000;

        _originVehicle setVariable ["gradTnT_bpz_vehicleHooked", _vehicle, true];
        {
            _x params ["_rope"];
            [_vehicle, (_corners select _forEachIndex), [0,0,-1]] ropeAttachTo _rope;
        } forEach _ropes;
    };
};

grad_bpz_fnc_detachRopes = {
    private _vehicles = nearestObjects [player, ["LandVehicle"], 5];
    private _vehicle = objNull;

    if (count _vehicles > 0) then {
        _vehicle = _vehicles select 0;

        private _originVehicle = player getVariable ["gradTnT_ropesVehicle", objNull];
        private _hook = _vehicle getVariable ["gradTnT_bpz_hookVehicle", objNull];
        private _helper = player getVariable ["gradTnT_ropesHelper", objNull];
        private _ropes = player getVariable ["gradTnT_ropes", []];

        player setVariable ["gradTnT_ropesPickedUp", false, true];
        _hook setVariable ["canHook", true, true];

        {
            _x params ["_rope"];
            player ropeDetach _rope;
        } forEach _ropes;

        deleteVehicle _helper;

        private _corners = [_vehicle] call grad_bpz_fnc_getCornerPoints;
        private _oldMass = _vehicle getVariable ["gradTnT_originalMass", 5000];
        _vehicle setMass _oldMass;
        _originVehicle setVariable ["gradTnT_bpz_vehicleHooked", objNull, true];
        {
            _x params ["_rope"];
            [_vehicle, (_corners select _forEachIndex), [0,0,-1]] ropeDetach _rope;
        } forEach _ropes;
    };
};



grad_bpz_fnc_findNearbyFreeRopes = {
    private _ropes = [];
    private _hooks = (nearestObjects [player, ["gm_bpz2a1_hook"], 30]);
    private _vehicle = objNull;
    private _hook = objNull;

    if (count _hooks > 0) then {
        _hook = _hooks select 0;
        if (_hook getVariable ["canHook", false]) then {
            _vehicle = _hook getVariable ["gradTnT_bpz_hookVehicle", objNull];
            _ropes = _vehicle getVariable ["gradTnT_bpz_ropesHook", []];
        };
    };

    [_ropes, _hook, _vehicle]
};


grad_bpz_fnc_pickupAction = {
    params ["_player"];
    private _nearByRopes = call grad_bpz_fnc_findNearbyFreeRopes;
    
    [_nearByRopes, _player] call grad_bpz_fnc_pickupRopes;  
};



[{
    params ["_args", "_handle"];

    private _nearByRopes = call grad_bpz_fnc_findNearbyFreeRopes;
    missionNamespace setVariable ["gradTnT_nearByRopes",_nearByRopes];

}, 2, []] call CBA_fnc_addPerFrameHandler;


player addAction ["Pickup Hook Ropes", { 
    [player] call grad_bpz_fnc_pickupAction;
}, nil, 0, false, true, "", "call grad_bpz_fnc_canPickUpRopes"];

player addAction ["Drop Hook Ropes", { 
    [player] call grad_bpz_fnc_dropRopes;
}, nil, 0, false, true, "", "call grad_bpz_fnc_canDropRopes"];

player addAction ["Attach Ropes", { 
    [player] call grad_bpz_fnc_attachRopes;
}, nil, 0, false, true, "", "call grad_bpz_fnc_canAttachRopes"];