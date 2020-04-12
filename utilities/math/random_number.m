function num = random_number(a, b, dec_int, size_num)
% num = random_number(a, b, dec_int [OPTIONAL], size_num [OPTIONAL])
%
% DESCRIPTION:
%    This function generates a random number between the given upper and 
%    lower boundaries. The output can be either an integer value or a 
%    floating point decimal value. If the choice for the output is 'int', 
%    then the boundaries "a" and "b" must be integers; otherwise, they will
%    be rounded to the nearest integer. If a choice is not provided, then 
%    the default value of 'dec' will be used.
%    An optional fourth input may be provided, which shall be the desired
%    size of the array of random numbers, all between the given boundaries.
%    If this fourth input is provided, then the third input is required, as
%    well (it can be empty to use the default).
%
% INPUTS:
%    a (1x1 DOUBLE) - lower boundary
%    b (1x1 DOUBLE) - upper boundary
%    dec_int (STRING) - choice between integer or decimal value for chosen
%       random number; choices: 'int' or 'dec'; default is 'dec'
%    size_num (MxN DOUBLE) - size of array of generated random numbers
%
% OUTPUTS:
%    num (MxN DOUBLE) - randomly chosen number between a and b, inclusive

if nargin == 0
    num = rand;
    return
end

%% Input Validation

% Number of args
assert(nargin==2||nargin==3||nargin==4, 'This function requires either 2, 3, or 4 inputs.')
assert(nargout==0||nargout==1, 'This function does not return more than 1 output.')

% Bounds A and B
assert(isnumeric(a)&&length(a)==1, 'The input ''a'' must be a single, numeric value.')
assert(isnumeric(b)&&length(b)==1, 'The input ''b'' must be a single, numeric value.')
assert(a<b, 'The lower boundary must be LESS THAN the upper boundary.')

% Dec/Int Flag
if ~exist('dec_int','var') || isempty(dec_int)
    dec_int = 'dec'; % default
end
assert(ischar(dec_int), 'The input ''dec_int'' must be a string.')
switch lower(dec_int)
    case {'dec' 'decimal' 'd'}
        dec_int = 'dec';
    case {'int' 'integer' 'i'}
        dec_int = 'int';
    otherwise
       error('The input ''dec_int'' was not a valid choice. Choices are ''dec'' or ''int''.')
end

% Size
if ~exist('size_num','var') || isempty(size_num)
    size_num = [1 , 1]; % default
end
assert(isnumeric(size_num), 'The input ''size_num'' must be numeric.')
assert(ismatrix(size_num), 'The input ''size_num'' only supports 2 dimensional arrays.')

%% Actual Function

m = size_num(1);
n = size_num(2);
num = zeros(m, n);

switch dec_int
    case 'int'
        a = round(a) - 0.5;
        b = round(b) + 0.5;
        for i = 1:m
            for j = 1:n
                num(i,j) = round(a+(b-a)*rand);
            end
        end
    case 'dec'
        for i = 1:m
            for j = 1:n
                num(i,j) = a+(b-a)*rand ;
            end
        end
end

end