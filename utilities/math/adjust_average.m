function new_avg = adjust_average(old_avg, new_datapoint, N)
% new_avg = adjust_average(old_avg, new_datapoint, N)
%
% DESCRIPTION:
%    This function updates an average in the absence of all of the rest of
%    the data. The function takes in the old average, a single new point,
%    and what the total number of points is (including the new point).
%
% INPUTS:
%    old_avg (1x1 DOUBLE) - average of dataset before new point is included
%    new_datapoint (1x1 DOUBLE) - new point to be included in the overall
%       dataset average
%    N (1x1 DOUBLE) - total number of points in the averaged dataset
%       (including the new_datapoint)
%
% OUTPUTS:
%    new_avg (1x1 DOUBLE) - average of dataset after new point is included

%% Input Validation

assert(nargin==3, 'This function requires exactly three inputs.')
assert(nargout<=1, 'This function does not return more than 1 output.')

assert(isnumeric(old_avg), 'The input ''old_avg'' must be numeric.')
assert(isnumeric(new_datapoint), 'The input ''new_datapoint'' must be numeric.')
assert(isnumeric(N), 'The input ''N'' must be numeric.')

assert(all(size(old_avg)==[1,1]), 'The input ''old_avg'' must be size (1x1).')
assert(all(size(new_datapoint)==[1,1]), 'The input ''new_datapoint'' must be size (1x1).')
assert(all(size(N)==[1,1]), 'The input ''N'' must be size (1x1).')

%% Actual Function

old_weight = (N-1)/N;
new_weight = 1/N;

new_avg = old_weight*old_avg + new_weight*new_datapoint;

end