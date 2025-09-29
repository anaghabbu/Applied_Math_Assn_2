function strandbeest_main()

    solver_params = struct();
    solver_params.dxtol = 1e-7;
    solver_params.ftol = 1e-8;
    solver_params.max_iter = 200;
    solver_params.dxmax = 1e6;
    solver_params.numerical_diff = 1e6;


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
    
    theta_in = 0;
        
    % Call function to find errors between current positions of vertex 2 and
    % center of crank rotation and the fixed values of what they should be 
    fixed_coord_error_func(matrix_coords, leg_params, theta_in);

    % iterate through the code below to get new vertex coordinate positions
    % these coordinates will go into the visualization function

    complete_vertex_coords = zeroes(10, 100);
    count = 0;

    for i = 0 : 100

        count = count + 1;
        theta_in = theta_in + 0.01;
        vertex_coords_root = compute_coords(vertex_coords, solver_params, leg_params, theta_in);

        complete_vertex_coords(:, 1) = vertex_coords_root;
    end

    for j = 1 : 100

        update_leg_drawing(complete_vertex_coords(:,j), leg_drawing, leg_params)
    end
end


get the vertex coords of the leg at theta: 0.1 by
using the compute coords function

put it into leg visualizer 
    update leg will then iterate through each "pair" of values to get linnkages
    it will then iterate through each x, y coord to get vertices

now there will be one leg position on the visualizer

to get more frames, use a for loop to iterate though theta values with computes coords and
then update leg within the for loop
theta = ,1;

for i = 1:100
     
    vertex_coords_root = compute_coords(vertex_coords, solver_params, leg_params, theta_in);
    update_leg_drawing(vertex_coords_root, leg_drawing, leg_params)
    theta = theta + 0.01
end





