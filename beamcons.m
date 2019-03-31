function [ceq,GCeq]=beamcons(u,d,kc,stdx) %kc is not necessary for one performance function but can be used to loop through multiple performance functions

%cons computes the values of a constraint (performance) function and its
%gradients at a given MPP estimate u, number of constraints

    x = u.*stdx+d; %Transform u to x
    ceq=600/(u(4)*u(5)^2)*u(2) + 600/(u(4)^2*u(5))*u(1) - u(3); %Performance function
    GCeq(1)=((600*u(5))/(u(4)^2))*stdx(1); %Gradient WRT X
    GCeq(2)=(600/(u(4)*u(5)^2))*stdx(2); %Gradient WRT Y
    GCeq(3)=-stdx(3); %Gradient WRT Sy
    GCeq(4)=-((600*(2*u(5)^3*u(1)+u(4)*u(2)))/(u(5)^2*u(4)^3))*stdx(4); %Gradient wrt w
    GCeq(5)=((600*(u(5)^3*u(1)-2*u(4)*u(2)))/(u(5)^3*u(4)^2))*stdx(5); %Gradient wrt t
end