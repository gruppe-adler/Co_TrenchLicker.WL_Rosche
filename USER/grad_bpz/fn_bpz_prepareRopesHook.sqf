params [["_hook", objNull], ["_vehicle", objNull]];

private _dummyHookPoint = "ace_fastroping_helper" createVehicle [0,0,0];
_dummyHookPoint attachTo [_hook, [0,0,-0.5]];

private _ropesHook = []; // _vehicle getVariable ["gradTnT_bpz_ropesHook", []];

// create ropes that get attached to wreck in the end

for "_i" from 1 to 4 do
{
    private _dummyRopeEnd = "ace_fastroping_helper" createVehicle [0,0,0];
    _dummyRopeEnd setPos (getPos _dummyHookPoint);
    _dummyRopeEnd hideObjectGlobal true;

    private _rope = ropeCreate [_dummyHookPoint, [0,0,0], 1];
    _ropesHook pushBack [_rope, _dummyRopeEnd, _hook];
};


/*
systemChat format ["gradTnT_bpz_ropesHook %1", _ropesHook];
diag_log format ["gradTnT_bpz_ropesHook %1", _ropesHook];
*/

_vehicle setVariable ["gradTnT_bpz_ropesHook", _ropesHook, true];
_hook setVariable ["canHook", true, true];

/*
    [[1efba1bcb80# 3928998: rope.p3d,1efa2ab0080# 3928997: helper.p3d,1efa37a9600# 3928947: gm_bpz2_hook.p3d],
    [1ef6b688100# 3929002: rope.p3d,1efaf21e040# 3929001: helper.p3d,1efa37a9600# 3928947: gm_bpz2_hook.p3d],
    [1efbc00a080# 3929006: rope.p3d,1ef8c7a6040# 3929005: helper.p3d,1efa37a9600# 3928947: gm_bpz2_hook.p3d],
    [1ef81778b80# 3929010: rope.p3d,1ef6c81a040# 3929009: helper.p3d,1efa37a9600# 3928947: gm_bpz2_hook.p3d]]
*/