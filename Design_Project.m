%% ME 591 Design Project - Mechanical Component Design under Uncertainty
% Shreyas Sudhakar - Spring 2019

%% Initialization
clc; clear all; close all;

%% Part 1
% Define means and standard deviations
u_X = 500; %Mean of  X [lb]
s_X = 100; %STDev of  X [lb]
u_Y = 1000; %Mean of Y [lb]
s_Y = 100; %STDev of  Y [lb]
u_Sy = 400000; %Mean of Sy [psi]
s_Sy = 20000; %STDev of  Sy [psi]
u_w = 2; %Mean of w [in]
s_w = 0.02; %STDev of  w [in]
u_t = 1; %Mean of t [in]
s_t = 0.01; %STDev of  t [in]

[mean_stress,std_stress,mean_yield_strength,std_yield_strength,mean_G,std_G,Rel_MCS] = beamMCS(u_X,s_X,u_Y,s_Y,u_Sy,s_Sy,u_w,s_w,u_t,s_t);

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
u_w_b = 2; %Mean of w [in]
u_t_b = 1.15; %Mean of t [in]
[mean_stress_b,std_stress_b,mean_yield_strength_b,std_yield_strength_b,mean_G_b,std_G_b,Rel_MCS_b] = beamMCS(u_X,s_X,u_Y,s_Y,u_Sy,s_Sy,u_w_b,s_w,u_t_b,s_t);
answer5b = sprintf('The reliability of this design is %d.',Rel_MCS_b);
disp(answer5b);

%% Part 5c
u_w_c = 2.4; %Mean of w [in]
u_t_c = 1; %Mean of t [in]
[mean_stress_c,std_stress_c,mean_yield_strength_c,std_yield_strength_c,mean_G_c,std_G_c,Rel_MCS_c] = beamMCS(u_X,s_X,u_Y,s_Y,u_Sy,s_Sy,u_w_c,s_w,u_t_c,s_t);
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

