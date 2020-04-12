function mkdir_smart(new_dir)
% mkdir_smart(new_dir)
%
% DESCRIPTION:
%    This function only makes a directory if it does not exist already. If
%    the directory exists already, then the function simply quits, with no
%    messages or outputs.
%
% INPUTS:
%    new_dir (STRING) - full or relative path to the directory that the
%       user would like to create
%
% OUTPUTS: none

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout==0, 'This function does not return any outputs.')

assert(ischar(new_dir), 'The input ''new_dir'' must be a character array.')

%%

[path, ~, ext] = fileparts(new_dir);

% Make sure the user did not accidentally provide a file
assert(isempty(ext), sprintf( ...
    ['This function is for creating new directories. \n', ...
    'It looks like you provided a filename.']))

if exist(path,'dir') == 7
    % If the directory exists, then move on
    return
else
    % If the directory does not exist, then make it
    mkdir(path)
end

end