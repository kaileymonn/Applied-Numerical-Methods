function [x,FLAG] = BroydensMethod(F,x,tol,N)
% Implements Broyden's Method to solve F(x)=0
% Inputs: F = Function handle returning column vector of values
% x = initial guess
% tol = tolerance for change in solution x
% N = maximum number of iterations
%
% Outputs: x = approximation of root, FLAG = exit code


% Newton's method step

% Find Jacobian matrix
delta = 1e-8;
J = zeros(length(x));
id = 1:length(x);
for ii = id
    J(:,ii) = (F(x+delta*(id==ii).')...
        -F(x-delta*(id==ii).'))/(2*delta);
end

% Get new approximation
wi = F(x);
Ainv = inv(J);
s = -Ainv*wi;

x = x + s; % new approximation

wf = F(x);
y = wf - wi;

i=0;
FLAG = 0;
while(FLAG==0)
    % update Ainv approximation
    Ainv = Ainv + (s-Ainv*y)*s.'*Ainv/(s.'*Ainv*y);
    s = -Ainv*wf;
    
    x = x+s; % new root approximation
    
    wi = wf;
    wf = F(x);
    y = wf - wi;
    
    % termination criteria
    if norm(s)<tol % for small change in x, use norm(wf)<tol for small residual
        FLAG = 1; % exited correctly
        break
    end
    
    i = i+1;
    if i>=N % limit number of iterations
        FLAG = -1; % didn't converge
        break
    end
end