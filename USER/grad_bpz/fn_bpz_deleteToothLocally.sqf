params ["_positionHookASL", "_hookObj"];

private _nearestDragonTooth = lineIntersectsWith [_positionHookASL, _positionHookASL vectorAdd [0,0,-1], _hookObj];

if (count _nearestDragonTooth > 0 && typeOf (_nearestDragonTooth#0) == "Land_DragonsTeeth_01_1x1_old_F") then {
	deleteVehicle (_nearestDragonTooth#0);
};
