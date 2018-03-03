function [x,FLAG] = steepestDescent(g,init,tol)
FLAG = 1;
x = init(:);
k = 0;
while(FLAG==1)
	g1 = g(x);
	
	% Approximate gradient
	delta = 1e-13;
	z = zeros(size(x));
	id = 1:numel(x);
	for i = 1:numel(x)
		z(i) = (g(x+delta*(id==i).')-g(x-delta*(id==i).'))/(2*delta);
	end
	z0=norm(z);
	
	if z0 == 0
		FLAG = 0; % maybe a local minimum
	end
	
	z = z/z0;
	
	alpha3 = 1;
	g3 = g(x-alpha3*z);
	
	while g3>g1
		alpha3 = alpha3/2;
		g3 = g(x-alpha3*z);
		
		if alpha3<tol/2
			FLAG = 1; % no likely improvement
		end
	end
	
	alpha2 = alpha3/2;
	g2 = g(x-alpha2*z);
	
	% quadratic approximation
	h1 = (g2-g1)/alpha2;
	h2 = (g3-g2)/(alpha3-alpha2);
	h3 = (h2-h1)/alpha3;
    
	% minimum of quadratic
	alpha0 = (alpha2-h1./h3)/2;
	g0 = g(x-alpha0*z);
	
	[~,id] = min([g0 g1 g2 g3]);
	alph = [alpha0 0 alpha2 alpha3];
	alpha = alph(id);
	
	% new approximation
	x = x - alpha*z;
	g(x)
    plot(x)
	if abs(g1-g(x))<tol
		FLAG = 2; % little/no change from previous approximation
	end
	
	% to avoid an infinite loop...
	k = k+1;
	if k>10000
		FLAG = -1;
	end
end