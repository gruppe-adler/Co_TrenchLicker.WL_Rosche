params ["_type", "_posAGL"];

private _tooth = allSimpleObjects [_type] inAreaArray [_posAGL, 3,3];

{
	deleteVehicle _x;	

	private _source2 = "#particlesource" createVehicleLocal [0, 0, 0];  
	_source2 setPos _posAGL;  
	_source2 setParticleCircle [0, [0, 0, 2]];  
	_source2 setParticleRandom [0, [1, 1, 1], [5, 5, 3], 0, 0.1, [0, 0, 0, 0.1], 0, 0];  
	_source2 setParticleParams [
		["a3\structures_f_tank\military\fortifications\dragonsteeth_01_1x1_old_f.p3d", 1, 0, 1], "", "SpaceObject", 0.5, 120, 
		[0, 0, 3], [0, 0, 0], 0.5, 200, 20, 3.75, [0.1,0.1,0.1], [[0.3, 0.3, 0.3, 1], [0.3, 0.3, 0.3, 0.3], [0.3, 0.3, 0.3, 0]], 
		[0.08], 1, 0, "", "", _this,0,true,0.1
	];  
	_source2 setDropInterval 0.001;
	
	[{ 
		params ["_source2"]; 
		deleteVehicle _source2; 
	}, [_source2] ,0.1] call CBA_fnc_waitAndExecute;

} forEach _tooth;
