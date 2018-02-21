function w = heun(f,t,alpha)
% f = f(t,y) is RHS function of ODE
% t is evenly-spaced vector of dependent variable grid points
% alpha is initial condition

h = t(2) - t(1); % calculate grid spacing

w = zeros(size(t)); % initialise results vector

w(1) = alpha; % initial condition

for i = 1:length(t)-1
    % Heun's method steps
    k1 = f(t(i),w(i));
    k2 = f(t(i) + h/3, w(i) + k1*h/3);
    k3 = f(t(i) + 2*h/3, w(i) + 2*h*k2/3);
    
    w(i+1) = w(i) + h/4*(k1 + 3*k3);
end