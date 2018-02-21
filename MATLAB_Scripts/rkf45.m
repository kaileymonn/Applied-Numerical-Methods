function [t,w,FLAG] = rkf45(f,a,b,alpha,tol,hmin,hmax)
% f = f(t,y) is RHS function of ODE to be solved over
% interval a<=t<=b, with initial condition y(a)=alpha.
% tol specifies error bound, hmin and hmax are minimum
% and maximum allowable step sizes
% w is the vector of approximations to y(t) at times in
% vector t. FLAG gives termination state of function,
% 1 = all good, 2 = hmin too big to satisfy error tolerance

w = alpha; % initialise result vector with initial condition
t = a; % time vector
FLAG = 0; % termination condition flag
i = 1; % succesful iteration counter (offset by 1)
h = hmax; % test step-size for first step

while FLAG==0
    % calculate the ki's
    k1 = h*f(t(i),w(i));
    k2 = h*f(t(i)+h/4,w(i)+k1/4);
    k3 = h*f(t(i)+3*h/8,w(i)+3*k1/32+9*k2/32);
    k4 = h*f(t(i)+12*h/13,w(i)+1932*k1/2197-7200*k2/2197+7296*k3/2197);
    k5 = h*f(t(i)+h,w(i)+439*k1/216-8*k2+3680*k3/513+845*k4/4104);
    k6 = h*f(t(i)+h/2,w(i)-8*k1/27+2*k2-3544*k3/2565+1859*k4/4104-11*k5/40);
    
    % calculate the error directly
    R = 1/h*abs(k1/360-128*k3/4275-2197*k4/75240+k5/50+2*k6/55);
    
    if R<tol % if the error is small enough, accept the step
        % update approximation
        w(i+1) = w(i) + 25*k1/216+1408*k3/2565+2197*k4/4104-k5/5;
        t(i+1) = t(i) + h;
        
        i = i+1; % increment step counter
        
        % if we have reached t=b, we are done
        if abs(t(i)-b)<1e-15 % or t(i)>=b
            FLAG = 1; % successful completion, exit while loop
            break
        end
    end
    
    % find q
    q = max(min(0.84*(tol/R)^(1/4),4),0.1);
    
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










