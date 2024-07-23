params ["_exploPos", "_size"];

[_exploPos] execvm "user\scripts\smoke.sqf";
[_exploPos] execvm "user\scripts\shockwave.sqf";

for "_i" from 0 to 5 do {
	_exploPos set [2, (_exploPos#2 + _i*6)];
	[_exploPos, _size/((_i+1)/4)] execvm "user\scripts\explosion.sqf";
	sleep 0.1;
};

