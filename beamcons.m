function [ceq,GCeq]=beamcons(u,d,kc,stdx) %kc is not necessary for one performance function but can be used to loop through multiple performance functions

%cons computes the values of a constraint (performance) function and its
%gradients at a given MPP estimate u, number of constraints

    x = u.*stdx+d; %Transform u to x
    ceq=1-80/(x(1)^2+8*x(2)+5); %Performance function
    GCeq(1)=x(1)*160*stdx(1)/((x(1)^2+8*x(2)+5))^2; %Gradient WRT X1
    GCeq(2)=80*8*stdx(2)/((x(1)^2+8*x(2)+5))^2; %Gradient WRT X2
end