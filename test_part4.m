function test_part4()

    % x_guess = [1;2;3];
    x_guess = rand(3,1);
    solver_params = struct();
    solver_params.dxtol = 1e-10;
    solver_params.ftol = 1e-10;
    solver_params.max_iter = 200;
    solver_params.dxmax = 1e8;
    solver_params.numerical_diff = 1;
    
    [x_root] = multi_newton_solver(@test_function01,x_guess,solver_params);
    
    disp(x_root)
    f_root = test_function01(x_root);
    disp(f_root)
    
    [x_root] = multi_newton_solver(@test_function02,x_guess,solver_params);
    
    disp(x_root)
    f_root = test_function02(x_root);
    disp(f_root)
    
    
    
    x_guess = [pi/4; 11];
    
    
    [x_root] = multi_newton_solver(@traj_error ,x_guess,solver_params)

    traj_error(x_root)

    run_simulation(x_root(1), x_root(2))


end

