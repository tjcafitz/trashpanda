function [optimal_soln, f_best] = differential_evolution(fxn, high, low, Npop, Ngen, pc, F, opt)
% [optimal_soln, f_best] = optimize.differential_evolution(fxn, high, low, Npop, Ngen, pc, F, opt)
%
% DESCRIPTION:
%    This function is a Differential Evolution optimization algorithm that
%    can be applied to a generic function of n variables. Based on the
%    options chosen, there are a few different selection methods and
%    mutation methods available.
%    The mutant vector is calculated with the following equation:
%        v = x_r0 + F(x_r1 - x_r2)
%    Here, 'x_r0' is the 'base vector' and 'x_r[12]' are the 'difference
%    vectors'. The difference vectors are always selected at random. In all
%    methods, r0 ~= r1 ~= r2 ~= i.
%    --> SELECTION METHODS:
%        'random': Base vectors are chosen at random. No additional options
%            are required for this method.
%        'best_so_far': Only the best (so far) solution vector is used as
%            the base vector. This vector is cycled through until the trial
%            population is the same size as the current population.
%         'random_best_blend': A random vector is selected. The base vector
%             is selected that lies somewhere on the line between this
%             vector and the best so far vector. Where on the line it lies
%             is a random number between 0 and 1, inclusive.
%    --> F ALTERATION METHODS:
%        'constant': The value of F remains constant, at the user set
%            value. F is size (1,1) for this method.
%        'jitter': The value of F changes for every variable when creating
%            each mutant vector. The value is randomly selected between the
%            user set bounds. F is size (1,2) for this method.
%        'dither': The value of F changes for each mutant vector, but the
%            same F is applied to each variable. The value is randomly
%            selected between the user set bounds. F is size (1,2) for this
%            method.
%    --> SURVIVAL METHODS: (note that, for all survival methods, both
%        generations, current and next, combine their populations into one;
%        then, half of the members are selected to survival to bring the
%        group back to the size of the original population)
%        'natural_selection': The coombined population is sorted, and the
%            best Npop members survive.
%         'tournament': Each member competes against opt.T other members.
%             The number of wins for each member is recorded. The Npop
%             members with the most wins survive.
%         'weighted_random': Each member is assigned a probability. The
%             probabilities are based either on rank or cost (chosen with
%             opt.weight). Selection is done by simulating a roulette
%             wheel.
%
% INPUTS:
%    fxn [FUNCTION HANDLE] - function to be optimized; must be am "@"
%       function handle, pointing to a function on the current path
%    high (1,n) [DOUBLE] - upper limits for all variables
%    low (1,n) [DOUBLE] - lower limits for all variables
%    Npop (1,1) [DOUBLE] - number of population members
%    Ngen (1,1) [DOUBLE] - maximum number of generations allowed
%    pc (1,1) [DOUBLE] - probability of crossover; must be a number
%        between 0 and 1, inclusive
%    F (1,1) or (1,2) [DOUBLE] - scaling factor when applying difference
%        vector to base vector (recommended 0.4 <= F <= 1)
%    opt (1,1) [STRUCT] - options structure with the fields:
%        .sel_method [STRING] - selection method for base vector; choices:
%            'random', 'best_so_far', 'random_best_blend'
%        .F_method [STRING] - method for F; choices: 'constant', 'jitter',
%            'dither'
%        .surv_method [STRING] - method for choosing survivors; choices:
%            'natural_selection', 'tournament'
%        .T (1,1) [DOUBLE] - number of opponents in each tournament
%        .weight [STRING] - choice of how to calculate selection
%            probabilities; choices: 'rank', 'cost'
%
% OUTPUTS:
%    optimal_soln (1,n) [DOUBLE] all variables for the optimal solution
%    f_best (1,1) [DOUBLE] - minimum cost (cost function evaluated at
%        optimal_soln)
%
% REFERENCES:
%     Price, Kenneth V., Rainer M. Storm, & Jouni A. Lampinen.
%         "Differential Evolution: A Practical Approach to Global
%         Optimization"

%% Input Validation

assert(nargin==8, 'This function requires exactly 8 inputs.')
assert(nargout<=2, 'This function does not return more than 2 outputs.')

% function to optimize
assert(isa(fxn,'function_handle'), 'The input ''fxn'' must be valid function handle.')

% variable limits
assert(isnumeric(high), 'The input ''high'' must be numeric.')
assert(isnumeric(low), 'The input ''low'' must be numeric.')
high = force.row(high);
low = force.row(low);
n = length(high);
assert(all([1,n]==size(high)), 'The input ''high'' must be 1 dimensional.')
assert(all(size(high)==size(low)), 'The inputs ''high'' and ''low'' must be the same size.')
assert(all(high>low), 'All elements of the input ''high'' must be greater than their matching element of the input ''low''.')

% population/generation info
assert(isnumeric(Npop), 'The input ''Npop'' must be numeric.')
assert(isnumeric(Ngen), 'The input ''Ngen'' must be numeric.')
assert(all([1,1]==size(Npop)), 'The input ''Npop'' must be size (1,1).')
assert(all([1,1]==size(Ngen)), 'The input ''Ngen'' must be size (1,1).')

% probability of crossover
assert(isnumeric(pc), 'The input ''pc'' must be numeric.')
assert(all([1,1]==size(pc)), 'The input ''pc'' must be size (1,1).')
assert(pc<=1&&pc>=0, 'The input ''pc'' must be between 0 and 1, inclusive.')

% options
assert(isstruct(opt), 'The input ''opt'' must be a STRUCT.')
assert(isfield(opt,'sel_method'), 'The input ''opt'' must contain the field ''sel_method''.')
assert(ischar(opt.sel_method), 'The input ''opt.sel_method'' must be class CHAR.')
switch opt.sel_method
    case {'random', 'best_so_far', 'random_best_blend'}
    otherwise
        error('Invalid ''opt.sel_method'' choice!')
end
assert(isfield(opt,'F_method'), 'The input ''opt'' must contain the field ''F_method''.')
assert(ischar(opt.F_method), 'The input ''opt.F_method'' must be class CHAR.')
switch opt.F_method
    case {'constant', 'jitter', 'dither'}
    otherwise
        error('Invalid ''opt.F_method'' choice!')
end
assert(isfield(opt,'surv_method'), 'The input ''opt'' must contain the field ''surv_method''.')
assert(ischar(opt.surv_method), 'The input ''opt.surv_method'' must be class CHAR.')
switch opt.surv_method
    case 'natural_selection'
        % do nothing
    case 'tournament'
        assert(isfield(opt,'T'), 'The input ''opt'' must contain the field ''T''.')
        assert(isnumeric(opt.T), 'The input ''opt.T'' must be numeric.')
        assert(all([1,1]==size(opt.T), 'The input ''opt.T'' must be size (1,1).'))
        assert(isfield(opt,'weight'), 'The input ''opt'' must contain the field ''weight''.')
        assert(ischar(opt.weight), 'The input ''opt.weight'' must be class CHAR.')
        switch opt.weight
            case {'rank', 'cost'}
            otherwise
                error('Invalid ''opt.weight'' choice!')
        end
    otherwise
        error('Invalid ''opt.F_method'' choice!')
end

% scaling factor
assert(isnumeric(F), 'The input ''F'' must be numeric.')
F = force.row(F);
switch opt.F_method
    case 'constant'
        assert(all([1,1]==size(F)), 'The input ''F'' must be size (1,1).')
    case {'jitter', 'dither'}
        assert(all([1,2]==size(F)), 'The input ''F'' must be size (1,2).')
end

%% Pre-Allocation

% Finalcost for each population member (of a given generation)
f = zeros(Npop, 1);

% Average, minimum, and maximum cost for each generation
avgcost = zeros(Ngen, 1);
mincost = avgcost;
maxcost = avgcost;

%% Generate Initial Population

% Pre-allocate with random normalized values
popn = rand(Npop, n);

% Un-normalize the Values
popn = (high-low).*popn + low;

%% Iterate Generations

% Calculate fitness value for each member
for member = 1:Npop
    f(member) = feval(fxn, popn(member,:));
end

% Run the algorithm
for gen = 1:Ngen
    % generate statistics for the current generation
    avgcost(gen) = mean(f);
    mincost(gen) = min(f);
    maxcost(gen) = max(f);
    
    % Select mating pool and mate to create next generation
    [popn, f] = next_generation(fxn, popn, f, opt, high, low, pc, F);
end

%% Post-Processing

% Pull out final results
[f_best, ind] = min(f);
optimal_soln = popn(ind,:);

% Statitstics
figure
hold on
xlabel('Generation')
ylabel('Cost')
title('Cost Max, Min, & Avg over Generations')
plot(1:Ngen, maxcost, 'r')
plot(1:Ngen, mincost, 'g')
plot(1:Ngen, avgcost, 'b')
legend('Maximum', 'Minimum', 'Average', 'Location', 'Best')

% Display results to command window
fprintf('Optimal Solution: \n');
for i = 1:n
    fprintf('   Var %d: %5.4f\n', i, optimal_soln(i));
end
fprintf('\nFinal Minimum Value: %5.4f\n', f_best);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [new_popn, new_f] = next_generation(fxn, old_popn, old_f, opt, high, low, pc, F)
% DESCRIPTION:
%    This function is the iterative looper of the main function:
%        "optimize.differential_evolution.m"
%    This function takes a population and generates a new population (the
%    next generation). The new population will have the same number of
%    members and same number of variables as the initial population.
%
% INPUTS:
%    fxn [STRING] - function to be optimized; must be a string containing
%        the name of the function stored as a .m file on the current path
%    old_popn (Npop,Nvar) [DOUBLE] - array of current generation's
%        population
%    old_f (Npop,1) [DOUBLE] cost values for each member of the population
%    opt (1,1) [STRUCT] - options structure (full descriptions in main
%        function descrption)
%    high (1,n) [DOUBLE] - upper limits for all variables
%    low (1,n) [DOUBLE] - lower limits for all variables
%    pc (1,1) [DOUBLE] - probability of crossover; must be a number
%        between 0 and 1, inclusive
%    F (1,1) or (1,2) [DOUBLE] - scaling factor when applying difference
%        vector to base vector (recommended 0.4 <= F <= 1)
%
% OUTPUTS:
%    new_popn (Npop,Nvar) [DOUBLE] - array of next generation's population
%    new_f (Npop,1) [DOUBLE] - cost values for each member of the next
%        generation's population

%% BEGIN!

[Npop, Nvar] = size(old_popn);

% Pre-Allocation
trial_popn = old_popn;
new_popn   = old_popn*0;

trial_f = old_f;
new_f   = old_f*0;

%% Base Vector Selection

% === Random Selection ===
% Select base vectors so that r0 ~= i
random_decimals = rand(Npop, 1);
[~, random_indices] = sort(random_decimals); % turn decimals into integers with only unique values
% If any r0 == i, re-try
while any(random_indices'==1:Npop)
    random_decimals = rand(Npop, 1);
    [~, random_indices] = sort(random_decimals); % turn decimals into integers with only unique values
end
random_popn = old_popn(random_indices,:);

% === Best So Far ===
[~, best_index] = min(old_f);
best_indices = best_index*ones(Npop, 1);
best_popn = old_popn(best_indices,:);

switch opt.sel_method
    case 'random'
        % Take the purely random selection
        base_vec = random_popn;
        
    case 'best_so_far'
        % Take only the raw best so far
        base_vec = best_popn;
        
    case 'random_best_blend'
        % Blend between the random selection and the best so far (just use
        % the random decimals from before, since they are indeed random)
        base_vec = random_popn + random_decimals.*(best_popn-random_popn);
end

%% Generate All Trial Vectors

for tv = 1:Npop
    % Choose Target Vector
    target_vec = old_popn(tv,:);
    
    % Choose Two Random Population Members So That r1 ~= r2 ~= i
    choice1 = random_number(1, Npop, 'int');
    choice2 = random_number(1, Npop, 'int');
    while choice1==choice2 || choice1==tv || choice2==tv
        % If they match, just try again
        choice1 = random_number(1, Npop, 'int');
        choice2 = random_number(1, Npop, 'int');
    end
    
    % Compute Weighted Difference Vector
    if strcmpi(opt.F_method,'constant')
        difference_vec = F*(old_popn(choice1,:) - old_popn(choice2,:));
    elseif strcmpi(opt.F_method,'jitter')
        for i = 1:Nvar
            difference_vec(i) = random_number(F(1),F(2),'dec')*(old_popn(choice1,i) - old_popn(choice2,i));
        end
    elseif strcmpi(opt.F_method,'dither')
        difference_vec = random_number(F(1),F(2),'dec')*(old_popn(choice1,:) - old_popn(choice2,:));
    end
    % Add to Base Vector
    mutant_vec = base_vec(tv,:) + difference_vec;
    
    % Crossover
    trial_popn(tv,:) = target_vec;
    for i = 1:Nvar
        if rand <= pc
            trial_popn(tv,i) = mutant_vec(i);
        end
        % Ensure bounds not breached
        if     trial_popn(tv,i) > high(i)
            trial_popn(tv,i) = high(i);
        elseif trial_popn(tv,i) < low (i)
            trial_popn(tv,i) = low(i);
        end
    end
    trial_f(tv) = feval(fxn,trial_popn(tv,:));
end

all_popn = [old_popn ; trial_popn];
all_f    = [old_f    ; trial_f   ];

%% Determine Which Members Survive
sorted_popn = all_popn*0; % Pre-Allocation
% --------------------------- Natural Selection ---------------------------
if strcmp(opt.surv_method,'natural_selection')
    [sorted_f , I] = sort(all_f);
    for v = 1:Nvar
        sorted_popn(:,v) = all_popn(I,v);
    end
    
    new_popn = sorted_popn(1:Npop,:);
    new_f    = sorted_f   (1:Npop)  ;
    
    % ------------------------------ Tournament -------------------------------
elseif strcmp(opt.surv_method,'tournament')
    wins = all_f*0; % Pre-Allocation
    for i = 1:(2*Npop)
        available = [1:(i-1) , (i+1):(2*Npop)];
        tally = 0;
        for comp = 1:opt.T
            c = random_number(1,length(available),'int');
            competitor = available(c);
            if all_f(competitor) <= all_f(i)
                tally = tally + 1;
            end
            available(c) = [];
        end
        wins(i) = tally;
    end
    [~ , I] = sort(wins);
    for v = 1:Nvar
        sorted_popn(:,v) = all_popn(I,v);
    end
    sorted_f = all_f(I);
    
    new_popn = sorted_popn(1:Npop,:);
    new_f    = sorted_f   (1:Npop)  ;
    
    % ---------------------------- Weighted Random ----------------------------
elseif strcmp(opt.surv_method,'weighted_random')
    % Pre-Allocate Probability Array
    P = zeros(2*Npop,1);
    % Probability Assignment
    if strcmpi(opt.weight,'rank')
        den = sum(1:(2*Npop));
        for member = 1:(2*Npop)
            P(member) = ((2*Npop)-member+1)/den;
        end
    elseif strcmpi(opt.weight,'cost')
        normalizer = min(all_f);
        for member = 1:(2*Npop)
            C(member) = all_f(member) - normalizer; %#ok<AGROW>
        end
        den = sum(C);
        if den ~= 0
            for member = 1:(2*Npop)
                P(member) = abs(C(member)/den);
            end
        else
            P = P + 1/(2*Npop);
        end
    end
    available = (1:1:(2*Npop))';
    for i = 1:Npop
        % "Spin" The Wheel
        spin = random_number( 0,sum(P),'dec' );
        % March Through Probability Matrix Until The "Spun" Slice Is Hit
        for j = 1:length(P)
            if spin <= sum(P(1:j))
                new_popn(i,:) = all_popn(available(j),:);
                new_f   (i)   = all_f   (available(j))  ;
                P(j) = [];
                available(j) = [];
                break
            end
        end
    end
end

end