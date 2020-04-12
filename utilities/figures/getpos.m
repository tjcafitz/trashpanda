function getpos(fh)
% getpos(fh)
%
% DESCRIPTION:
%    This function reads the 'Position' property of a figure handle
%    (current figure by default), and prints the requisite new figure
%    command to the Command Window for the user to create a new figure that
%    is the same size, and in the same location.
%    The function accepts one input, which is to be the figure handle in
%    question. If not provided, then the current figure is selected.
%
% INPUTS:
%    fh (1x1 handle) - handle of figure to have 'Position' queried
%
% OUTPUTS: none

%% Input Validation

switch nargin
    case 0
        fh = gcf;
    case 1
        % Good
    otherwise
        error('This function accepts either 0 or 1 inputs.')
end
assert(nargout==0, 'This function does not return any outputs.')

assert(ishandle(fh), 'The input ''fh'' must be a valid handle.')
assert(all(size(fh)==[1,1]), 'The input ''fh'' must be size (1x1).')

%% Query & Report

% Use the "get" command instead of dot notation, so that the function can
% handle the case of a simple number being passed in for the figure handle,
% instead of an actual figure handle object
pos = get(fh, 'Position');
num = get(fh,'Number');

% Print results
fprintf('\n');
fprintf('Figure Handle: %i\n', num)
fprintf('figure(''Position'', [%i, %i, %i, %i]);\n', pos(1), pos(2), pos(3), pos(4))
fprintf('\n');

end