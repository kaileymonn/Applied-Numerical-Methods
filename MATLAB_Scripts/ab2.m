function w = ab2(f,t,alpha)
% f = f(t,y) is RHS function of ODE
% t is evenly-spaced vector of dependent variable grid points
% alpha is initial condition

h = t(2) - t(1); % calculate grid spacing

w = zeros(size(t)); % initialise results vector

w(1:2) = alpha; % initial condition

for i = 2:length(t)-1
    w(i+1) = w(i) + h/2*(3*f(t(i),w(i))-f(t(i-1),w(i-1)));
end
