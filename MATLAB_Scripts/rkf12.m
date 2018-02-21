function [t,w,FLAG] = rkf12(f,a,b,alpha,tol,hmin,hmax)
w = alpha; % initialise result vector with initial condition
t = a; % time vector
FLAG = 0; % termination condition flag
i = 1; % succesful iteration counter (offset by 1)
h = hmax; % test step-size for first step
while FLAG==0
    % calculate the ki's
    k1 = h*f(t(i),w(i));
    k2 = h*f(t(i)+h,w(i)+k1);
    
    % calculate the error directly
    R = 1/h*abs(-k1/2 + k2/2);
    
    if R<tol % if the error is small enough, accept the step
        % update approximation
        w(i+1) = w(i) + k1/2 + k2/2;
        t(i+1) = t(i) + h;
        
        i = i+1; % increment step counter
        
        % if we have reached t=b, we are done
        if abs(t(i)-b)<1e-15 % or t(i)>=b
            FLAG = 1; % successful completion, exit while loop
            break
        end
    end
    
    % find q
    q = max(min(0.5*(tol/R),4),0.1);
    
    % Need h<=hmax
    h = min(q*h,hmax);
    if h<hmin
        % but if h too small, quit with a flag to idicate the error
        FLAG = 2;
        break
    end
    
    % ensure the last time-step finishes at t=b
    if t(i)+h>b
        h = b-t(i);
    end
end
