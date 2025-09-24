%Error function that encodes the fixed vertex constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% same input as link_length_error_func
%leg_params: a struct containing the parameters that describe the linkage
% importantly, leg_params.crank_length is the length of the crank
% and leg_params.vertex_pos0 and leg_params.vertex_pos2 are the
% fixed positions of the crank rotation center and vertex 2.
%theta: the current angle of the crank
%OUTPUTS:
%coord_errors: a column vector of height four corresponding to the differences
% between the current values of (x1,y1),(x2,y2) and
% the fixed values that they should be
function coord_errors = fixed_coord_error_func(matrix_coords, leg_params, theta_in)
    coord_errors = zeros(4, 1); % Initialize 4x1 vector

    % Define fixed vertex positions
    x0_fixed = leg_params.vertex_pos0(1);
    y0_fixed = leg_params.vertex_pos0(2);
    x2_fixed = leg_params.vertex_pos2(1);
    y2_fixed = leg_params.vertex_pos2(2);

    % Extract vertex guesses from matrix
    vertex_1 = leg_params.link_to_vertex_list(1, 1); % extract vertex 2 from list of vertices
    vertex_2 = leg_params.link_to_vertex_list(3, 1); % extract vertex 2 from list of vertices
    x1_guess = matrix_coords(vertex_1, 1); 
    y1_guess = matrix_coords(vertex_1, 2);
    x2_guess = matrix_coords(vertex_2, 1);
    y2_guess = matrix_coords(vertex_2, 2);

    % Define vertex 1 position over time
    x1_current = x0_fixed + leg_params.crank_length.*cos(theta_in);
    y1_current = y0_fixed + leg_params.crank_length.*cos(theta_in);
    
    % Create error vector
    coord_errors(1) = x1_guess - x1_current - leg_params.crank_length.*cos(theta_in);
    coord_errors(2) = y1_guess - y1_current - leg_params.crank_length.*sin(theta_in);
    coord_errors(3) = x2_guess - x2_fixed;
    coord_errors(4) = y2_guess - y2_fixed;
end
