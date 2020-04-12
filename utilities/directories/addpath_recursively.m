function addpath_recursively(dir_to_add)
% addpath_recursively(dir_to_add)
%
% DESCRIPTION:
%    This function starts from a directory, and adds that directory to the
%    MATLAB path. It then marches into that directory, and adds all folders
%    and subfolders within that directory to the MATLAB path as well.
%
% INPUTS:
%    dir_to_add (STRING) - full or relative path to the top directory to
%       add to the MATLAB path, along with all its children folders
%
% OUTPUTS: none

%% Input Validation

assert(nargin==1, 'This function requires exactly one input.')
assert(nargout==0, 'This function does not return any outputs.')

assert(ischar(dir_to_add), 'The input ''dir_to_add'' must be a character array.')

assert(isdir(dir_to_add), 'The directory you have pointed to does not exist.')

%%

% Start by adding the top directory
addpath(dir_to_add);

% See what's inside
whats_inside = dir_smart(dir_to_add);

% Check if any of the contents are also directories
idx_dirs_inside = cellfun(@(name) isdir(fullfile(dir_to_add,name)), ...
    {whats_inside.name});
idx_dirs_inside = find(idx_dirs_inside);

% Loop through each, calling this very function
for i = idx_dirs_inside
    addpath_recursively(fullfile(dir_to_add, whats_inside(i).name))
end

end