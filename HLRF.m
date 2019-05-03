function [beta,R,u,ceq,GCeq,dbeta]=HLRF(x,kc,stdx,cons)

%HL_RF uses the HL-RF method to conduct an MPP search and compute the
%reliability using FORM.

    u=zeros(1,length(x)); %Initialize vector to hold u
    iter=0; %Set iteration count to zero 
    Dif=1; %Initialize convergence criteria to unconverged
    sign = 1; 

    while Dif >= 1d-5 && iter < 20 %Convergence criteria, stop after 20 tries
        iter=iter + 1; %Increment iteration counter
        [ceq,GCeq]=cons(u,x,kc,stdx); %Compute performance function and gradients at current iteration
        u=(GCeq*u'-ceq)/norm(GCeq)^2*GCeq; %Update search at current iteration
        U(iter,:)=u/norm(u);
        
        if iter ==1
            sign = -ceq/abs(ceq);
        elseif iter>1
            Dif=abs(U(iter-1,:)*U(iter,:)' - 1); %Compute difference in U between iterations for convergence criteria
        end
    end

    beta = sign*norm(u); %Compute reliability index
    dbeta = -u./(beta*stdx);
    R = normcdf(beta); %Compute reliability  
end