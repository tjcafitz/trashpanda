function [constant_value, constant_units] = constants(constant_name)
% [constant_value, constant_units] = constants(constant_name)
%
% DESCRIPTION:
%    This function looks up values of various constants. The input must be
%    a string. The string is NOT case sensitive, but it must be an exact 
%    match of characters.
%    To see a list of all available constants, their values, and their
%    units, call the function with no inputs.
%
% INPUTS:
%    constant_name (STRING) - desired constant to look up
%
% OUTPUTS:
%    constant_value (1x1 NUMBER) - numerical value of desired constant
%    constant_units (STRING) - units of desired constant
%
% REFERENCES:
%    Curtis, Howard D. "Orbital Mechanics for Engineering Students", 2e
%    Wikipedia, "Standard gravitational parameter"
%    Vallado, David A. "Fundamentals of Astrodynamics and Applications", 4e

%% Input Validation

assert(nargin<=1, 'This function requires either 0 or 1 inputs.')
assert(nargout<=2, 'This function returns either no more than 2 outputs.')

%% All Variables

all_vars = { ...
    ... Celestial Bodies' Radii
    'radius Sun'           ,         695800, 'km'      ;
    'radius Mercury'       ,           2440, 'km'      ;
    'radius Venus'         ,           6052, 'km'      ;
    'radius Earth'         ,           6378, 'km'      ;
    'radius Moon'          ,         1737.4, 'km'      ;
    'radius Mars'          ,           3390, 'km'      ;
    'radius Jupiter'       ,          69911, 'km'      ;
    'radius Saturn'        ,          58232, 'km'      ;
    'radius Uranus'        ,          25362, 'km'      ;
    'radius Neptune'       ,          24622, 'km'      ;
    'radius Pluto'         ,           1184, 'km'      ;
    'radius Eris'          ,           1400, 'km'      ;
    ... Celestial Bodys' Sphere of Influence Diameters
    'SOI Mercury'          ,         112000, 'km'      ;
    'SOI Venus'            ,         616000, 'km'      ;
    'SOI Earth'            ,         925000, 'km'      ;
    'SOI Moon'             ,          66100, 'km'      ;
    'SOI Mars'             ,         577000, 'km'      ;
    'SOI Jupiter'          ,       48200000, 'km'      ;
    'SOI Saturn'           ,       54800000, 'km'      ;
    'SOI Uranus'           ,       51800000, 'km'      ;
    'SOI Neptune'          ,        3080000, 'km'      ;
    'SOI Pluto'            ,         112000, 'km'      ;
    ... Celestial Bodys' Standard Gravitational Parameters
    'mu Sun'               ,   132712440018, 'km^3/s^2';
    'mu Mercury'           ,          22032, 'km^3/s^2';
    'mu Venus'             ,         324859, 'km^3/s^2';
    'mu Earth'             ,    398600.4418, 'km^3/s^2';
    'mu Moon'              ,         4902.8, 'km^3/s^2';
    'mu Ceres'             ,          42828, 'km^3/s^2';
    'mu Mars'              ,           63.1, 'km^3/s^2';
    'mu Jupiter'           ,      126686534, 'km^3/s^2';
    'mu Saturn'            ,       37931187, 'km^3/s^2';
    'mu Uranus'            ,        5793939, 'km^3/s^2';
    'mu Neptune'           ,        6836529, 'km^3/s^2';
    'mu Pluto'             ,            871, 'km^3/s^2';
    'mu Eris'              ,           1108, 'km^3/s^2';
    ... Celestial Bodys' Orbital Periods
    'period Mercury'       ,     7600530.24, 's'       ;
    ... Mean Planetary Constants for Epoch J2000 (VALLADO p. 1041 Table D-3 and D-4)
    'a Mercury'            ,       57909083, 'km'      ;
    'a Venus'              ,      108208601, 'km'      ;
    'a Earth'              ,      149598023, 'km'      ;
    'a Mars'               ,      227939186, 'km'      ;
    'a Jupiter'            ,      778298361, 'km'      ;
    'a Saturn'             ,     1429394133, 'km'      ;
    'a Uranus'             ,     2875038615, 'km'      ;
    'a Neptune'            ,     4504449769, 'km'      ;
    'a Pluto'              ,     5915799000, 'km'      ;
    'e Mercury'            ,    0.205631752, 'none'    ;
    'e Venus'              ,    0.006771882, 'none'    ;
    'e Earth'              ,    0.016708617, 'none'    ;
    'e Mars'               ,     0.09340062, 'none'    ;
    'e Jupiter'            ,    0.048494851, 'none'    ;
    'e Saturn'             ,    0.055508622, 'none'    ;
    'e Uranus'             ,    0.046295898, 'none'    ;
    'e Neptune'            ,    0.008988095, 'none'    ;
    'e Pluto'              ,        0.24905, 'none'    ;
    'i Mercury'            ,     7.00498625, 'deg'     ;
    'i Venus'              ,      3.9446619, 'deg'     ;
    'i Earth'              ,              0, 'deg'     ;
    'i Mars'               ,     1.84972648, 'deg'     ;
    'i Jupiter'            ,     1.30326966, 'deg'     ;
    'i Saturn'             ,      2.4888781, 'deg'     ;
    'i Uranus'             ,     0.77319617, 'deg'     ;
    'i Neptune'            ,     1.76995221, 'deg'     ;
    'i Pluto'              ,    17.14216667, 'deg'     ;
    'RAAN Mercury'         ,    48.33089304, 'deg'     ;
    'RAAN Venus'           ,    76.67992019, 'deg'     ;
    'RAAN Earth'           ,              0, 'deg'     ;
    'RAAN Mars'            ,    49.55809321, 'deg'     ;
    'RAAN Jupiter'         ,   100.46444064, 'deg'     ;
    'RAAN Saturn'          ,    113.6655237, 'deg'     ;
    'RAAN Uranus'          ,    74.00594723, 'deg'     ;
    'RAAN Neptune'         ,   131.78405702, 'deg'     ;
    'RAAN Pluto'           ,   110.29713889, 'deg'     ;
    'omega Mercury'        ,    77.45611904, 'deg'     ;
    'omega Venus'          ,   131.56370724, 'deg'     ;
    'omega Earth'          ,   102.93734808, 'deg'     ;
    'omega Mars'           ,   336.06023398, 'deg'     ;
    'omega Jupiter'        ,    14.33130924, 'deg'     ;
    'omega Saturn'         ,    93.05678728, 'deg'     ;
    'omega Uranus'         ,   173.00515922, 'deg'     ;
    'omega Neptune'        ,     48.1236905, 'deg'     ;
    'omega Pluto'          ,   224.13486111, 'deg'     ;
    'lambda_M Mercury'     ,   252.25090551, 'deg'     ;
    'lambda_M Venus'       ,   181.97980084, 'deg'     ;
    'lambda_M Earth'       ,   100.46644851, 'deg'     ;
    'lambda_M Mars'        ,   355.43327463, 'deg'     ;
    'lambda_M Jupiter'     ,    34.35148392, 'deg'     ;
    'lambda_M Saturn'      ,    50.07747138, 'deg'     ;
    'lambda_M Uranus'      ,   314.05500511, 'deg'     ;
    'lambda_M Neptune'     ,   304.34866548, 'deg'     ;
    'lambda_M Pluto'       ,   238.74394444, 'deg'     ;
    ... Miscellaneous Earth Information
    'eccentricity of Earth', 0.081819221456, 'none'    ;
    };

%% Show Available Inputs

if nargin==0
    clc
    fprintf( '::: AVAILABLE CONSTANTS :::\n' );
    fprintf( '\n' );
    fprintf( '    Constant                        Value           Units\n' );
    fprintf( '------------------------------------------------------------\n' );
    for i = 1:length(all_vars)
        fprintf('%-30s %16.10f %s\n', all_vars{i,1}, all_vars{i,2}, all_vars{i,3});
    end
    return
end

%% Retrieve Value

index = find(cellfun(@strcmpi, ...
    all_vars(:,1), ...
    repmat({constant_name},size(all_vars(:,1)))));

if isempty(index)
    error('Constant not found. Try a different name.')
else
    constant_value = all_vars{index,2};
    constant_units = all_vars{index,3}; 
end

end