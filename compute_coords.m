%Computes the vertex coordinates that describe a legal linkage configuration
%INPUTS:
%vertex_coords_guess: a column vector containing the (x,y) coordinates of every vertex
% these coords are just a GUESS! It's used to seed Newton's method
%leg_params: a struct containing the parameters that describe the linkage
%theta: the desired angle of the crank
%OUTPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
% these coords satisfy all the kinematic constraints!
function vertex_coords_root = compute_coords(vertex_coords_guess, solver_params, leg_params, theta)
    fun = @(vertex_coords_in) linkage_error_func(vertex_coords_in, leg_params, theta);
    vertex_coords_root = multi_newton_solver(fun, vertex_coords_guess, solver_params);
end



%Error function that encodes all necessary linkage constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%error_vec: a vector describing each constraint on the linkage
% when error_vec is all zeros, the constraints are satisfied
function error_vec = linkage_error_func(vertex_coords, leg_params, theta)
    matrix_coords = column_to_matrix(vertex_coords);
    distance_errors = link_length_error_func(matrix_coords, leg_params);
    coord_errors = fixed_coord_error_func(matrix_coords, leg_params, theta);
    error_vec = [distance_errors;coord_errors];
end