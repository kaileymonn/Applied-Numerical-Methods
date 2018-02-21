function w = rk4(f,t,alpha)
% f = f(t,y) is RHS function of ODE
% t is evenly-spaced vector of dependent variable grid points
% alpha is initial condition

h = t(2) - t(1); % calculate grid spacing

w = zeros(size(t)); % initialise results vector

w(1) = alpha; % initial condition

for i = 1:length(t)-1
    % 4th order Runge-Kutta
    k1 = h*f(t(i),w(i));
    k2 = h*f(t(i)+h/2,w(i)+k1/2);
    k3 = h*f(t(i)+h/2,w(i)+k2/2);
    k4 = h*f(t(i)+h,w(i)+k3);
    w(i+1) = w(i) + (k1+2*k2+2*k3+k4)/6;
end