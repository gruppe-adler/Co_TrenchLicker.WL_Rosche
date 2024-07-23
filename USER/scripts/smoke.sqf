params ["_position"];

private _size = 2;
private _life = 60;
private _smoke = "#particlesource" createVehicle _position;

_smoke setParticleRandom [0.2 * _life, [2.5 * _size, 2.5 * _size, 0.1], [0.4, 0.4, 0.5], 0.5, 0.2 * _size, [0.05, 0.05, 0.05, 0.2],1,0.1 * _size,360];
private _col = [[0,0,0,0.5],[0,0,0,0]];
_smoke setParticleParams [["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48,1],"", "Billboard", 1, 0.1 * _life, [0, 0, 0],[0,0,20], 1, 1.275, 1, 0.01, [5 * _size,25 * _size],_col,[0.5,0.15,0.1],1,0,"","",_smoke,0];	
_smoke setDropInterval 0.07;

[{ params ["_source"]; deleteVehicle _source; }, [_smoke], 600] call CBA_fnc_waitAndExecute;