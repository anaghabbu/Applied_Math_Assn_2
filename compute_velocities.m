%Computes the theta derivatives of each vertex coordinate for the Jansen linkage

% INPUTS:

% vertex_coords: a column vector containing the (x,y) coordinates of every vertex, these are assumed to be legal values that are roots of the error funcs!
% leg_params: a struct containing the parameters that describe the linkage
% theta: the current angle of the crank

% OUTPUTS:

% dVdtheta: a column vector containing the theta derivates of each vertex coord

function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)
	
	% Compute Jacobian of error function
	F = @(V) link_length_error_func(V, leg_params); 
    J = approximate_jacobian(F, vertex_coords);

    % Calculate derivatives for the crank tip
  	r = leg_params.crank_length; % length of the crank shaft noted in additional constraints
    	odx1_dtheta = -r * sin(theta);
    	dy1_dtheta =  r * cos(theta);

    % Build M
    
    % The top is a 4x14 where the first 4 columns are the identity
    % matrix and the last 10 columns are trailing zeros. 

    % Only care about the x1 y1 and x2 y2 because you compare 
    % crank circle vertex with stationary

    identity = eye(4);
    Z = zeros(4, length(vertex_coords)-4);  % the trailing 10 zero columns
    top_block = [identity, Z];

    M = [top_block; J];

    B = [dx1_dtheta; dy1_dtheta; zeros(length(vertex_coords)-2, 1)];

    % SOLVE
    
    dVdtheta = M \ B; % dVdtheta = M^-1 * B

    % Step 6: Get tip velocity from vertex 7
    % Possible Code (idk if below works):
    vX_tip = dVdtheta(13);
    vY_tip = dVdtheta(14);
    velocity_tip = [vX_tip; vY_tip]; % vector

    % PLOT

    % Have vertex_coords(X) change for each theta iteration
    quiver(vertex_coords(13), vertex_coords(14), vX_tip, vY_tip, 2) % scale of 2 


end
