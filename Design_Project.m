%% ME 591 Design Project - Mechanical Component Design under Uncertainty
% Shreyas Sudhakar - Spring 2019

%% Initialization
clc; clear all; close all;

%% Part 1
% Define means and standard deviations 

% Mean Vector is of the form [u_X u_Y u_Sy u_w u_t], where
% these parameters are (in order) Mean of  X [lb], Mean of Y [lb], Mean of 
% Sy [psi], Mean of w [in], Mean of t [in].

% StDev Vector is of the form [s_X s_Y s_Sy s_w s_t], where these parameters
% are (in order) STDev of  X [lb], STDev of  Y [lb], STDev of  Sy [psi],
% STDev of  w [in], and STDev of  t [in].

x = [500 1000 400000 2 1];
stdx = [100 100 20000 0.02 0.01];

[mean_stress,std_stress,mean_yield_strength,std_yield_strength,mean_G,std_G,Rel_MCS] = beamMCS(x,stdx);

answer1 = sprintf('The mean and standard deviations of stress are %d and %d psi respectively. The mean and standard deviations of yield strength are %d and %d psi respectively.',mean_stress,std_stress,mean_yield_strength,std_yield_strength);
disp(answer1);

%% Part 2 
answer2 = sprintf('The mean and standard deviations of G are %d and %d psi respectively.',mean_G,std_G);
disp(answer2);

%% Part 3
answer3 = sprintf('The reliability of this design is %d.',Rel_MCS);
disp(answer3);

%% Part 4a
kc = 1; %Only one limit state function
nd = length(x); %Number of design variables
cons = @beamcons; %Constraint function name
[beta_HLRF,R_HLRF,u_HLRF]=HLRF(x,kc,stdx,cons); %Compute reliability using HL-RF method

%% Part 4b


%% Part 5a
% See Above in parts 1 to 3

%% Part 5b

x5b = [500 1000 400000 2 1.15];

[mean_stress_b,std_stress_b,mean_yield_strength_b,std_yield_strength_b,mean_G_b,std_G_b,Rel_MCS_b] = beamMCS(x5b,stdx);
answer5b = sprintf('The reliability of this design is %d.',Rel_MCS_b);
disp(answer5b);

%% Part 5c
x5c = [500 1000 400000 2.4 1];

[mean_stress_c,std_stress_c,mean_yield_strength_c,std_yield_strength_c,mean_G_c,std_G_c,Rel_MCS_c] = beamMCS(x5c,stdx);
answer5c = sprintf('The reliability of this design is %d.',Rel_MCS_c);
disp(answer5c);

%% Part 5 discussion
% Of the three designs, design B is the only one that meets the target
% reliability. While design A would be the cheapest to manufacture, it is very far away
% from the target reliability, so would not be a good choice unless the
% business is willing to cut costs up front and pay more down the line in
% warranty repair costs. Design C comes close to the target reliability,
% but has a greater volume than design B, meaning that its manufacturing
% cost would be more expensive. However, if the manufacturer already had
% tooling to manufacture this design and did not have the tooling to
% manufacture design B, it may be a viable option at a slight sacrifice of
% reliability and per unit cost.

