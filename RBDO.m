%%%%%%%%%%   A 99 LINE RBDO CODE WRITTEN BY WANG P.F. & YOUN B.D.  %%%%%%%%
%% Modified by Shreyas Sudhakar for Design Project

function RBDO()
clear all; close all; clc; % Initialization
global nc nd nm bt stdx Iters Cost
nc=1; % Number of constraints
nd=2; % Number of design variables- 2 (t & w) 
cons = @optimizationcons; %Constraint function name
bt=norminv(0.9987,0,1); %Target reliability index - inverse of normal CDF (P, Mean, Standard Deviation) 
x0=[2 1]; %Initial design 
stdx=[0.02 0.01]; %Standard Deviation for Design Variable
lb=[1.0,0.5]; ub=[3.0,2.0]; %Lower and Upper Bounds for Design Variables
xp=x0; Iters=0;
options = optimoptions(@fmincon,'SpecifyConstraintGradient',true,'SpecifyObjectiveGradient',true,'Algorithm','interior-point');
[x,fval]=fmincon(@Costfun,x0,[],[],[],[],lb,ub,@frelcon,options)
%====================      Obj. Function   ===============================%
    function [f,g]= Costfun(x)
        f=x(1)*x(2); % Multiply the means of design variables (minimizing cross section area)
        g=[1 1]; %Gradient of the cost function wrt x1 and x2
        Cost=f;
    end
%====================  Define Constraints and Gradiants  =================%
    function [c,ceq,GC,GCeq] = frelcon(x)
        ceq=[]; GCeq=[];
        for j = 1:nc
            [G,~,~,~,~,DG]=HLRF(x,j,stdx,cons);
            beta(j)=bt-G;
            dbeta(:,j)=-DG;
        end
        c=beta; GC=dbeta;
        dx=norm(x-xp);
        if  dx>1d-5  || Iters == 0
            Iters=Iters+1;
            SHOW(Iters,x,c,GC);
        end
        xp = x;
    end

    function  SHOW(Iters,x,c,GC)%====== Display the Iteration Information=====%
        fprintf(1,'\n********** Iter.%d ***********\n' ,Iters);
        disp(['Des.: ' sprintf('%6.4f  ',x)]);
        disp(['Obj.: ' sprintf('%6.4f',Cost)]);
        if nm==1
            disp(['Cons.: ' sprintf('%6.4f  ',c)]);
        elseif nm==2
            disp(['Index.: ' sprintf('%6.4f ',bt-c)]);
        end
        disp(['Sens.: ' sprintf('%6.4f  ',GC)]);
        fprintf('\n\n')
    end
end

%%%%%%%%%%%%%%%%%%%%%%%% Notes to the Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
% This is a compact code for reliability based design optimization (RBDO) %
% which includes PMA with AMV algorithm and RIA with HL_RF algorithm.     %
% One mathematical example is solved for demonstration purpose.           %
%                                                                         %
% VARIABLE DEFINITION:                                                    %
% nc: number of constraints; nd: number of design variables;              %
% bt: target rel. index; nm: method choice, nm=1 means PMA with AMV; nm=2 %
% means RIA with HL_RF;                                                   %
% x0: initial design; stdx: standard deviation for design variable;       %
% lb & ub: lower bound and upper bound for design variables;              %
% iter: variable used to record iteration number of optimization process  %
%                                                                         %
% FUNCTION DEFINITION                                                     %
% RBDO(): main function                                                   %
% Costfun(): objective function & gradients w.r.t. design variables       %
% frelcon(): Define the probability constraints and gradients             %
% AMV() & HL_RF(): AMV algorithm for PMA & HL_RF algorithm for RIA        %
% cons(): deterministic constraints and gradients evaluation              %
% SHOW(): show the optimization information for every design iteration    %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
