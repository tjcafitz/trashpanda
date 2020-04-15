function [min_val, q1, med_val, q3, max_val] = box_whisker(data_array)
% [min_val, q1, med_val, q3, max_val] = box_whisker(data_array)
%
% DESCRIPTION:
%    This function calcualtes the five values needed to create a
%    box-and-whisker plot.
%
% INPUTS:
%    data_array (1xN DOUBLE) - array of numbers to be evaluated
%
% OUTPUTS:
%    min_val (1x1 DOUBLE) - lowest value in array
%    q1 (1x1 DOUBLE) - first quartile of array
%    med_val (1x1 DOUBLE) - median value in array
%    q3 (1x1 DOUBLE) - third quartile array
%    max_val (1x1 DOUBLE) - highest value in array

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout<=5, 'This function does not return more than 5 outputs.')

assert(isnumeric(data_array), 'The input ''data_array'' must be numeric.')

N = length(data_array);
assert(N>=5, 'To calculate the five box-whisker values, ''data_array'' should be at least 5 values.')

data_array = force.row(data_array);
assert(all(size(data_array)==[1,N]), 'The input ''data_array'' must be one dimensional.')

%% Actual Function

% sort the data
data_array = sort(data_array);

% minimum
min_val = min(data_array);

% median
med_val = median(data_array);

% maximum
max_val = max(data_array);

% quartiles
switch mod(N,2)
    case 0
        % if there is an even number of values, just split it in half
        half_1 = data_array(1:(N/2));
        half_2 = data_array((N/2+1):end);
    case 1
        % if there is an odd number of values, then ignore the middle one
        half_1 = data_array(1:floor(N/2));
        half_2 = data_array(ceil(N/2):end);
end
q1 = median(half_1);
q3 = median(half_2);

end