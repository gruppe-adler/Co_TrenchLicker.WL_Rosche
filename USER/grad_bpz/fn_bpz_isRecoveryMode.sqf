private _vehicle = vehicle player;

(
	commander _vehicle == player &&
	_vehicle getVariable ["gradTnT_recoveryMode", false]
)