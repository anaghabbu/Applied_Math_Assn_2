% BASIC NEWTON'S METHOD IMPLEMENTATION

% Use multidimensional version of Newton's method of find a root of f(X)

X = [1;2;3]; % initial guess
[f_val, J] = test_function01(X);

% Tolerances and Iteration
tol = 1e-6;
max_iter = 50; 

for i = 1: max_iter
    [fval, J] = test_function01(X);
    
    X_new = X - (J \ f_val);

    % Check convergence (norm of update or residual)
    if norm((J \ f_val)) < tol || norm(f_val) < tol
        fprintf('Converged in %d iterations.\n', k);
        break;
    end

    X = X_new;

end

disp('Root is approx: ')
disp(X_new)

[f_check, ~] = test_function01(X_new);
disp('f(X_new) = ')
disp(f_check)

% Instead of inv(J) * F
% Do J\F


