function w = ab4(f,t,alpha)
% f = f(t,y) is RHS function of ODE
% t is evenly-spaced vector of dependent variable grid points
% alpha is initial condition

h = t(2) - t(1); % calculate grid spacing

w = zeros(size(t)); % initialise results vector

w(1:4) = alpha; % initial condition

for i = 4:length(t)-1
    w(i+1) = w(i) + h/24*(55*f(t(i),w(i))-59*f(t(i-1),w(i-1))+37*f(t(i-2),w(i-2))-9*f(t(i-3),w(i-3)));
end