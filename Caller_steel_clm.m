
%Igor M. Lima, Cleiton C. Pereira, Tiago S. Oliveira
%Dept. of Civil Engineering, IESB University Center
%SGAS Quadra 613/614 Asa Sul, 70200-730, Brasilia, Brazi
%i.g.moura@live.com, tiago.oliveira@iesb.br
%Brasilia, Brazil, June 29, 2021


%type kur_multiobjective.m % código para transcrever a função no command
% window
clear;

FitnessFunction = @steel_clm_xy_R1; % Function handle to the fitness function
numberOfVariables = 4; % Number of decision variables
lb = [100 4 4 100]; % Lower bound
ub = [400 25 25 600]; % Upper bound
A = []; b = []; % No linear inequality constraints
Aeq = []; beq = []; % No linear equality constraints
nonlcon = []; % Nonlinear constraints

% Options for GA implementation
options = gaoptimset('PopulationSize',400,'PopInitRange',[lb;ub],...
                     'FitnessScalingFcn',@fitscalingrank,...
                     'SelectionFcn',@selectionstochunif,...
                     'Generations', 25,'StallGenLimit',15,'TolFun',1e-6,...
                     'StallGenLimit',60,'TimeLimit',300,'UseParallel',false,...
                     'PlotFcns',{@gaplotbestf,@gaplotscores,@gaplotstopping});

%Mono-objective optimization process with the given options
[x_q,Fval,exitFlag,Output] = ga(FitnessFunction,numberOfVariables,A,b,Aeq,beq,lb,ub,nonlcon,options);
