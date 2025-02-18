function [iterations, X, residuals, g] = newton ( Xk, tol, nbiterations )
%NOWTON returns the zero of grad(g) = -b +Hx + 1/3 C(X)X, the minimum of g.
% newton ( X_0 ) uses default tolerance and a default value for maxiterations

maxiterations = nbiterations;
[~,H,~] = data;
dim = size(H, 2);
X1 = zeros(1, maxiterations);
X2 = zeros(1, maxiterations);
g = zeros(1, maxiterations);
residuals = zeros(1, maxiterations);
X1(1) = Xk(1);
X2(1) = Xk(2);
condition = 1;
norm_old = norm(grad(Xk));
g(1) = problem(Xk);
residuals(1) = norm_old;

while condition % the condition is calculated at the end of the while loop, because there should at least one iteration
    maxiterations = maxiterations - 1; % count from the maximum number of iterations to zero
    Xk = Xk - hessian(Xk) \ grad(Xk); % the algorithm of the newton method
    residual = norm( grad( Xk ) ) / norm_old; % the residual
    if dim == 2
        X1(nbiterations-maxiterations+1) = Xk(1);
        X2(nbiterations-maxiterations+1) = Xk(2);
    end
    condition = ( maxiterations > 0 ) && ( residual > tol );
    g(nbiterations-maxiterations+1) = problem(Xk);
    residuals(nbiterations-maxiterations+1) = residual;
end
X1 = X1(1:nbiterations-maxiterations+1);
X2 = X2(1:nbiterations-maxiterations+1);
X = [X1;X2];
iterations = (1:1:nbiterations-maxiterations+1);
g = g(1:nbiterations-maxiterations+1);
residuals = residuals(1:nbiterations-maxiterations+1);

end

