% SETTING UP TEST FUNCTION

%the function name and input/output variable names
%are just what I chose, you can use whatever names you'd like

function [f_val,J] = test_function01(X)
% Takes in column vector X as input and returns f(X) and J(X)
%your code here

    % Take X and assign x1, x2, x3 []
    x1 = X(1);
    x2 = X(2);
    x3 = X(3);

    f1 = x1^2 + x2^2 - 6 - x3^5;
    f2 = (x1*x3) + x2 -12;
    f3 = sin(x1 + x2 + x3);
    f_val = [f1; f2; f3];


    j1 = [2*x1, 2*x2, -5*x3^4];
    j2 = [x3, 1, x1];
    j3 = [cos(x1+x2+x3), cos(x1+x2+x3), cos(x1+x2+x3)];
    J = [j1; j2; j3];

    fprintf('f(X) = [%f %f %f]\n', f_val)

    disp('J = ')
    disp(J)

end

