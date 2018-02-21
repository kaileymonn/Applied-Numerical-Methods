function w = midpoint(f,t,alpha)
% f = f(t,y) is RHS function of ODE
% t is evenly-spaced vector of dependent variable grid points
% alpha is initial condition

h = t(2) - t(1); % calculate grid spacing

w = zeros(size(t)); % initialise results vector

w(1) = alpha; % initial condition

for i = 1:length(t)-1
    % Midpoint method's steps
    w(i+1) = w(i) + h*f(t(i)+h/2,w(i)+h/2*f(t(i),w(i)));
end