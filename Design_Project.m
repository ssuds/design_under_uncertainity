%% ME 591 Design Project - Mechanical Component Design under Uncertainty
% Shreyas Sudhakar - Spring 2019

%% Initialization
clc; clear all; close all;

%% Part 1
% Define means and standard deviations 
% Vector is of the form [u_X s_X u_Y s_Y u_Sy s_Sy u_w s_w u_t s_t], where
% these parameters are (in order) Mean of  X [lb], STDev of  X [lb], Mean
% of Y [lb], STDev of  Y [lb], Mean of Sy [psi], STDev of  Sy [psi], Mean
% of w [in], STDev of  w [in], Mean of t [in] and STDev of  t [in].
x = [500 100 1000 100 400000 20000 2 0.02 1 0.01];

[mean_stress,std_stress,mean_yield_strength,std_yield_strength,mean_G,std_G,Rel_MCS] = beamMCS(x);

answer1 = sprintf('The mean and standard deviations of stress are %d and %d psi respectively. The mean and standard deviations of yield strength are %d and %d psi respectively.',mean_stress,std_stress,mean_yield_strength,std_yield_strength);
disp(answer1);

%% Part 2 
answer2 = sprintf('The mean and standard deviations of G are %d and %d psi respectively.',mean_G,std_G);
disp(answer2);

%% Part 3
answer3 = sprintf('The reliability of this design is %d.',Rel_MCS);
disp(answer3);

%% Part 5a
% See Above in parts 1 to 3

%% Part 5b

x5b = [500 100 1000 100 400000 20000 2 0.02 1.15 0.01];

[mean_stress_b,std_stress_b,mean_yield_strength_b,std_yield_strength_b,mean_G_b,std_G_b,Rel_MCS_b] = beamMCS(x5b);
answer5b = sprintf('The reliability of this design is %d.',Rel_MCS_b);
disp(answer5b);

%% Part 5c
x5c = [500 100 1000 100 400000 20000 2.4 0.02 1 0.01];

[mean_stress_c,std_stress_c,mean_yield_strength_c,std_yield_strength_c,mean_G_c,std_G_c,Rel_MCS_c] = beamMCS(x5c);
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

