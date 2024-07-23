params ["_vehicle", "_enter"];


_vehicle setVariable ["gradTnT_recoveryMode", _enter, true];

if (_enter) then {
    // enter recovery mode
    // _vehicle animateSource ["crane_elev_source", 0.75];
    _vehicle animateSource ["crane_hook_unhide", 0];
    // _vehicle animateSource ["dozer_blade_elev_source", 1];
    // _vehicle animateSource ["crane_trav_source", 1];
    _vehicle setVariable ["gradTnT_isAnimating", true, true];

    _vehicle setCruiseControl [5, false];
    
    [_vehicle] call grad_bpz_fnc_bpz_dragonteethmagnet;

    // we need to take care the hook is not clipping / stuck in vehicle
    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "crane_elev_source" > 0.2) ||
        (_vehicle animationSourcePhase "crane_trav_source" > 0.2) ||
        !(_vehicle getVariable ["gradTnT_recoveryMode", false])

    },{
        params ["_vehicle"];
        
        if (_vehicle getVariable ["gradTnT_recoveryMode", false]) then {
            [_vehicle] call grad_bpz_fnc_bpz_prepareRopesCrane;
        };
        _vehicle setVariable ["gradTnT_isAnimating", false, true];

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;


} else {
    // exit recovery mode
    _vehicle animateSource ["crane_trav_source", 0.1];
    _vehicle animateSource ["crane_elev_source", 0];
    _vehicle animateSource ["dozer_blade_elev_source", 0];
    _vehicle setVariable ["gradTnT_isAnimating", true, true];
    
    [{
        params ["_vehicle"];

        (_vehicle animationSourcePhase "crane_trav_source" < 0.2)
    },{
        params ["_vehicle"];

         _vehicle setCruiseControl [0, false];
        
        _vehicle setVariable ["gradTnT_isAnimating", false, true];
        _vehicle animateSource ["crane_hook_unhide", 1];
        [_vehicle] call grad_bpz_fnc_bpz_removeRopesCrane;

    }, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
};