function dir_output = dir_smart(dir_input)
% dir_output = dir_smart(dir_input)
%
% DESCRIPTION:
%    This function runs the 'dir' command on the requested directory, and
%    returns the same output from that call, but without the useless
%    relative pathing answers (the '.' and '..').
%
% INPUTS:
%    dir_input (STRING) - full or relative path to the diectory to run the
%       'dir' command on
%
% OUTPUTS:
%    dir_output (STRING) - output of the 'dir' command, with the useless
%       information removed

%% Input Validation

assert(nargin==1, 'This function requires exactly 1 input.')
assert(nargout<=1, 'This function does not return more than 1 output.')

assert(ischar(dir_input), 'The input ''dir_input'' must be a character array.')
% Do NOT assert isdir, because the user might be searching using regular
% expressions, which will trick that check

%%

% See what's inside
dir_output = dir(dir_input);

% The call to 'dir' returns useless relative pathing info, '.' and '..' so
% remove them
this_dir = strcmp({dir_output.name},'.');
dir_output(this_dir) = [];

up_a_dir = strcmp({dir_output.name},'..');
dir_output(up_a_dir) = [];

end