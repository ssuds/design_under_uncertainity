function [ceq,GCeq]=beamcons(u,d,kc,stdx) %kc is not necessary for one performance function but can be used to loop through multiple performance functions

%cons computes the values of a constraint (performance) function and its
%gradients at a given MPP estimate u, number of constraints

    x = u.*stdx+d; %Transform u to x
    ceq=(600/(x(4)*x(5)^2))*x(2) + (600/(x(4)^2*x(5)))*x(1) - x(3); %Performance function
    GCeq(1)=((600*x(5))/(x(4)^2))*stdx(1); %Gradient WRT X
    GCeq(2)=(600/(x(4)*x(5)^2))*stdx(2); %Gradient WRT Y
    GCeq(3)=-stdx(3); %Gradient WRT Sy
    GCeq(4)=-((600*(2*x(5)^3*x(1)+x(4)*x(2)))/(x(5)^2*x(4)^3))*stdx(4); %Gradient wrt w
    GCeq(5)=((600*(x(5)^3*x(1)-2*x(4)*x(2)))/(x(5)^3*x(4)^2))*stdx(5); %Gradient wrt t
end