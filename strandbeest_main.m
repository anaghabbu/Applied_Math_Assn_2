function strandbeest_main()


    %initialize leg_params structure
    leg_params = struct();
    %number of vertices in linkage
    leg_params.num_vertices = 7;
    %number of links in linkage
    leg_params.num_linkages = 10;
    %matrix relating links to vertices
    leg_params.link_to_vertex_list = ...
    [ 1, 3;... %link 1 adjacency
    3, 4;... %link 2 adjacency
    2, 3;... %link 3 adjacency
    2, 4;... %link 4 adjacency
    4, 5;... %link 5 adjacency
    2, 6;... %link 6 adjacency
    1, 6;... %link 7 adjacency
    5, 6;... %link 8 adjacency
    5, 7;... %link 9 adjacency
    6, 7 ... %link 10 adjacency
    ];
    
    %list of lengths for each link
    %in the leg mechanism
    leg_params.link_lengths = ...
    [ 50.0,... %link 1 length
    55.8,... %link 2 length
    41.5,... %link 3 length
    40.1,... %link 4 length
    39.4,... %link 5 length
    39.3,... %link 6 length
    61.9,... %link 7 length
    36.7,... %link 8 length
    65.7,... %link 9 length
    49.0 ... %link 10 length
    ];
    
    %length of crank shaft
    leg_params.crank_length = 15.0;
    %fixed position coords of vertex 0
    leg_params.vertex_pos0 = [0;0];
    %fixed position coords of vertex 2
    leg_params.vertex_pos2 = [-38.0;-7.8];
    
    % Define vertex coordinates and convert to matrix form
    vertex_coords = [...
                    [ 0; 50];... %vertex 1 guess
                    [ -50; 0];... %vertex 2 guess
                    [ -50; 50];... %vertex 3 guess
                    [-100; 0];... %vertex 4 guess
                    [-100; -50];... %vertex 5 guess
                    [ -50; -50];... %vertex 6 guess
                    [ -50; -100]... %vertex 7 guess
                    ];
    
    matrix_coords = column_to_matrix(vertex_coords);
    
    % Call function to find link length errors
    link_length_error_func(matrix_coords, leg_params);
    
    theta_in = 0.1;
        
    % Call function to find errors between current positions of vertex 2 and
    % center of crank rotation and the fixed values of what they should be 
    fixed_coord_error_func(matrix_coords, leg_params, theta_in);

    error_vector = @(vertex_coords) linkage_error_func(matrix_coords, leg_params, theta_in);
    linkage_error_vector = error_vector(theta_in);
    root_of_vertex_coords = compute_coords(vertex_coords_guess, leg_params, theta, linkage_error_vector);
end

%Converts from the column vector form of the coordinates to a
%friendlier matrix form
%INPUTS:
%coords_in = [x1;y1;x2;y2;...;xn;yn] (2n x 1 column vector)
%OUTPUTS:
%coords_out = [x1,y1;x2,y2;...;xn,yn] (n x 2 matrix)
function coords_out = column_to_matrix(coords_in)
    num_coords = length(coords_in);
    coords_out = [coords_in(1:2:(num_coords-1)),coords_in(2:2:num_coords)];
end

%Converts from the matrix form of the coordinates back to the
%original column vector form
%INPUTS:
%coords_in = [x1,y1;x2,y2;...;xn,yn] (n x 2 matrix)
%OUTPUTS:
%coords_out = [x1;y1;x2;y2;...;xn;yn] (2n x 1 column vector)
function coords_out = matrix_to_column(coords_in)
    num_coords = 2*size(coords_in,1);
    coords_out = zeros(num_coords,1);
    coords_out(1:2:(num_coords-1)) = coords_in(:,1);
    coords_out(2:2:num_coords) = coords_in(:,2);
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
distance_errors = link_length_error_func(vertex_coords, leg_params);
coord_errors = fixed_coord_error_func(vertex_coords, leg_params, theta);
error_vec = [distance_errors;coord_errors];
end