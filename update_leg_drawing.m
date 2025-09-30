%Updates the plot objects that visualize the leg linkage
%for the current leg configuration
%INPUTS:
%complete_vertex_coords: a column vector containing the (x,y) coordinates of every vertex
%leg_drawing: a struct containing all the plotting objects for the linkage
% leg_drawing.linkages is a cell array, where each element corresponds
% to a plot of a single link (excluding the crank)

% leg_drawing.crank is a plot of the crank link
% leg_drawing.vertices is a cell array, where each element corresponds
% to a plot of one of the vertices in the linkage  
function update_leg_drawing(complete_vertex_coords, leg_drawing, leg_params)
   
    %iterate through each link, and update corresponding link plot
    % vertex_mat = column_to_matrix(complete_vertex_coords);

    for linkage_index = 1:leg_params.num_linkages
        %linkage_index is the label of the current link

        %line_x and line_y should both be two element arrays containing
        %the x and y coordinates of the line segment describing the current link
        current_vertices = leg_params.link_to_vertex_list(linkage_index, :);

        % a = current_vertices(1);
        % b = current_vertices(2);
        % pa = vertex_mat(a,:);
        % pb = vertex_mat(b,:);
        % line_x = [pa(1),pb(1)];
        % line_y = [pa(2),pb(2)];

        % line_x = [complete_vertex_coords(((current_vertices(1)*2)-1), iter), complete_vertex_coords(((current_vertices(2)*2)-1), iter)];
        % line_y = [complete_vertex_coords((current_vertices(1)*2), iter), complete_vertex_coords((current_vertices(1)*2), iter)];
        line_x = [complete_vertex_coords(current_vertices(1)*2-1), complete_vertex_coords(current_vertices(2)*2-1)];
        line_y = [complete_vertex_coords(current_vertices(1)*2), complete_vertex_coords(current_vertices(2)*2)];

        set(leg_drawing.linkages{linkage_index},'xdata',line_x,'ydata',line_y);
      
    end

    %iterate through each vertex, and update corresponding vertex plot
    count = 1;

    for vertex_index = 1:leg_params.num_vertices

        %vertex_index is the label of the current vertex
        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
     

        % dot_x = complete_vertex_coords(count, iter);
        % count = count + 1;
        % dot_y = complete_vertex_coords(count, iter);
        % count = count + 1;
        dot_x = complete_vertex_coords(count);
        count = count + 1;
        dot_y = complete_vertex_coords(count);
        count = count + 1;
        set(leg_drawing.vertices{vertex_index}, 'xdata', dot_x, 'ydata', dot_y);

    end


    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank

    % crank_x = [leg_params.vertex_pos0(1), complete_vertex_coords(1, iter)];
    % crank_y = [leg_params.vertex_pos0(2), complete_vertex_coords(2, iter)];
    crank_x = [leg_params.vertex_pos0(1), complete_vertex_coords(1)];
    crank_y = [leg_params.vertex_pos0(2), complete_vertex_coords(2)];
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y);

end
