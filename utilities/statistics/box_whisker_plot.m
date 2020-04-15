function box_whisker_plot(data_array, h_ax, y, DY, col, horiz)
% box_whisker_plot(data_array, h_ax, y, DY, col, horiz)
%
% DESCRIPTION:
%    This function plots a box-and-whisker plot on a specified axis.
%
% INPUTS:
%    data_array (1xN DOUBLE) - array of numbers to be evaluated
%    h_ax (1x1 HANDLE) - axis handle
%    y (1x1 DOUBLE) - y-value to plot the box and whiskers on
%    DY (1x1 DOUBLE) - height of center box to plot
%    col (1x3 DOUBLE) - RGB array for desired color of box
%    horiz (1x1 BOOLEAN) - logical for whether the plot should be
%       horizontal ('true') or vertical ('false'); NOTE that if this is set
%       to false, then the references to "y" should actually be considered
%       "x"
%
% OUTPUTS: none

%% Input Validation

assert(nargin==6, 'This function requires exactly 6 inputs.')
assert(nargout==0, 'This function does not return any outputs.')

% data_array
assert(isnumeric(data_array), 'The input ''data_array'' must be numeric.')
N = length(data_array);
assert(N>=5, 'To calculate the five box-whisker values, ''data_array'' should be at least 5 values.')
data_array = force.row(data_array);
assert(all(size(data_array)==[1,N]), 'The input ''data_array'' must be one dimensional.')

% h_ax
assert(all(size(h_ax)==[1,1]), 'The input ''h_ax'' must be size (1x1).')
assert(ishandle(h_ax), 'The input ''h_ax'' must be a valid axis handle.')

% y
assert(all(size(y)==[1,1]), 'The input ''y'' must be size (1x1).')

% DY
assert(all(size(DY)==[1,1]), 'The input ''DY'' must be size (1x1).')

% col
col = force.row(col);
assert(all(size(col)==[1,3]), 'The input ''col'' must be size (1x3).')

% horiz
assert(islogical(horiz), 'The input ''horiz'' must be a LOGICAL.')

%% Get Box-Whisker Values

[min_val, q1, med_val, q3, max_val] = box_whisker(data_array);

%% Plot It Up

% set the axis
axes(h_ax)

% adjust the height
DY = DY/2;
dy = DY/2;

% == box ==
if horiz
    fill([q1,q3,q3,q1,q1], y+[-1,-1,1,1,-1]*DY, col)
else
    fill(y+[-1,-1,1,1,-1]*DY, [q1,q3,q3,q1,q1], col)
end

% == lines alng trend ==
if horiz
    % min
    plot(min_val([1,1]), y+[-1,1]*dy, 'k')
    % median
    plot(med_val([1,1]), y+[-1,1]*DY, 'k--')
    % max
    plot(max_val([1,1]), y+[-1,1]*dy, 'k')
else
    % min
    plot(y+[-1,1]*dy, min_val([1,1]), 'k')
    % median
    plot(y+[-1,1]*DY, med_val([1,1]), 'k--')
    % max
    plot(y+[-1,1]*dy, max_val([1,1]), 'k')
    
end

% == lines perpendicular to trend ==
if horiz
    plot([min_val,q1], y([1,1]), 'k')
    plot([q3,max_val], y([1,1]), 'k')
else
    plot(y([1,1]), [min_val,q1], 'k')
    plot(y([1,1]), [q3,max_val], 'k')
end

end