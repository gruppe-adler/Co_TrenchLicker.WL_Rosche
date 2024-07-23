params ["_position", "_size"];

private _source01 = "#particlesource" createVehicleLocal _position;
_source01 setParticleClass "BombExp1";

private _params = ["BombExp1"] call BIS_fnc_getCloudletParams;

private _sizeParams = _params#0#11;
private _newSizeParams = [];
{
	private _newsize = _x * _size;
	_newSizeParams pushBack _newsize;
} forEach _sizeParams;

[_params, [0,11], _newSizeParams] call BIS_fnc_setNestedElement;


_source01 setParticleParams _params#0;

[{ params ["_source"]; deleteVehicle _source; }, [_source01], 2] call CBA_fnc_waitAndExecute;