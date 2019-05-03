function [ceq,GCeq]=optimizationcons(u,d,kc,stdx) %kc is not necessary for one performance function but can be used to loop through multiple performance functions

%cons computes the values of a constraint (performance) function and its
%gradients at a given MPP estimate u, number of constraints

    x = u.*stdx+d; %Transform u to x
    ceq=(600/(x(1)*x(2)^2))*1000 + (600/(x(1)^2*x(2)))*500 - 400000; %Performance function
    GCeq(1)=-((600*(2*x(2)^3*500+x(1)*1000))/(x(2)^2*x(1)^3))*stdx(1); %Gradient wrt w
    GCeq(2)=((600*(x(2)^3*500-2*x(1)*1000))/(x(2)^3*x(1)^2))*stdx(2); %Gradient wrt t
end