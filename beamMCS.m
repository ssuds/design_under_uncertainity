function [mean_stress,std_stress,mean_yield_strength,std_yield_strength,mean_G,std_G,Rel_MCS] = beamMCS(x,stdx)
%% Parse input vector
u_X = x(1);
s_X = stdx(1);
u_Y = x(2);
s_Y = stdx(2);
u_Sy = x(3);
s_Sy = stdx(3);
u_w = x(4);
s_w = stdx(4);
u_t = x(5);
s_t = stdx(5);

%% Generate MCS sample points
ns = 1000000;
xx = normrnd(u_X,s_X,1,ns);
yy = normrnd(u_Y,s_Y,1,ns);
sysy = normrnd(u_Sy,s_Sy,1,ns);
ww = normrnd(u_w,s_w,1,ns);
tt = normrnd(u_t,s_t,1,ns);

%% Evaluate G function at MCS sample points
zz = 600./(ww.*tt.^2).*yy + 600./(ww.^2.*tt).*xx - sysy;

%% Part 1 - Plot empirical PDF of stress [psi] and Yield Strength [psi]
figure;
nbar = 80;
stress = zz + sysy;
[heights,locations] = hist(stress,nbar);
width = locations(2)-locations(1);
heights = (heights/ns)/width;
bar(locations,heights,'b'); 
hold on;

% Compute distributional parameters of stress [psi]
mean_stress = mean(stress);
std_stress = std(stress);

% Superimpose the PDF based on distributional parameters
grid = linspace(min(stress),max(stress));
pdf = normpdf(grid,mean_stress,std_stress);
line(grid,pdf,'color','r');

% Plot empirical PDF of Yield Strength [psi]
nbar = 80;
yield_strength = sysy;
[heights,locations] = hist(yield_strength,nbar);
width = locations(2)-locations(1);
heights = (heights/ns)/width;
bar(locations,heights,'g'); hold on;
xlabel('{\color{blue}Stress} / {\color{green}Yield Strength} (psi)');
ylabel('Probability density');

% Compute distributional parameters of yield strength [psi]
mean_yield_strength = mean(yield_strength);
std_yield_strength = std(yield_strength);

% Superimpose the PDF based on distributional parameters
grid = linspace(min(yield_strength),max(yield_strength));
pdf = normpdf(grid,mean_yield_strength,std_yield_strength);
line(grid,pdf,'color','r');

%% Plot empirical PDF of Limit State Function
figure;

nbar = 80;
G = zz;
[heights,locations] = hist(G,nbar);
width = locations(2)-locations(1);
heights = (heights/ns)/width;
bar(locations,heights,'w'); hold on;
xlabel('Limit State Function G (psi)');
ylabel('Probability density');

% Compute distributional parameters of yield strength [psi]
mean_G = mean(G);
std_G = std(G);

% Superimpose the PDF based on distributional parameters
grid = linspace(min(G),max(G));
pdf = normpdf(grid,mean_G,std_G);
line(grid,pdf,'color','r');


%% Estimate reliability based on G values at MCS sample points
Rel_MCS = length(find(zz < 0))/ns;

end

