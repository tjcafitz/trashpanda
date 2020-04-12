function answer = ask_yes_or_no( question )
% answer = ask_yes_or_no( question )
%
% DESCRIPTION:
%    This function takes a character array (a question) and prints that
%    question to the command window. It appends ' [y/n]: ' and prompts an
%    input from the user. If the answer matches one of the functions 'yes'
%    options, then a TRUE boolean is returned. All other answers will
%    return a FALSE boolean.
%
% INPUTS:
%    question (STRING) - character array of the question to ask the user;
%       this string will be printed literally to the command window
%
% OUTPUTS:
%    answer (BOOL) - based on the user's answee to the question, this
%       output will be either TRUE or FALSE
%
% EXAMPLE:
%    >> ask_yes_or_no( 'Do you want to play a game?' ) ;

%% Input Validation
assert( nargin==1, 'This function requires exactly one input.' )
assert( nargout==0||nargout==1, 'This function either returns 0 or 1 outputs.' )

assert( ischar(question), 'The input ''question'' must be a character array.' )

%%
appended_question = [ question, ' [y/n]: ' ] ;
yes_or_no = input( appended_question, 's' ) ;

switch lower(yes_or_no)
    case {'yes' 'y' 'yea' 'yup' 'yee' 'uh-huh' 'o yea' 'oh yea' 'yep' 'yea buddy'}
        answer = true ;
        
    otherwise
        answer = false ;
        
end

end